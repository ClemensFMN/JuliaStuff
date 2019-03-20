# convolutional code functions

mutable struct ConvCode
	g 	# code polynomials - CAREFUL: they are stored as ints and NOT OCTALs!!
	K   # number of output streams
	nShiftRegs # number of shift registers
	nState # next state matrix - see below
	pState # previous state matrix - see below
	stateState # state-state transition - see below
	outP # output matrix - see below
	function ConvCode(g)
		K = length(g)
		# number of shift registers
		gmax = maximum(g)
		nShiftRegs = convert(Int,floor(log2(gmax)))
		# next state matrix
		# row = current state
		# col 1 = new state with input 0
		# col 2 = new state with input 1
		# this matrix does not depend on the polynomials but on the 
		nState = zeros(Int, 2^nShiftRegs, 2)
		for i=0:2^nShiftRegs-1
			# the shift register holds a bit pattern. which can be represented as number (that's the current state)
			# MSB of this number is in the rightmost shift register
			# after a new bit has been inserted, the state is shifted one position (causing the MSB to fall out)  
			temp = (i << 1) & (2^nShiftRegs - 1)
			nState[i+1,1] = temp | 0
			nState[i+1,2] = temp | 1
		end

		# pState matrix
		# row = current state
		# col 1,2 = prev state which lead to current state, independent of input
		pState = zeros(Int,2^nShiftRegs,2)
		for k=0:3
			ind = [] # wild hack :-(
			for b=1:2
				append!(ind, findall(x->x==k, nState[:,b]))
			end
			pState[k+1,:] = ind.-1
		end


		# stateState matrix
		# row = previous state
		# col = next state
		# value = information bit, which caused the state transition
		# some state transitions are not possible, in this case they are 0 as well...
		# we use this at the end of the viterbi to obtain a seq of inf.bits from a state seq
		# and the viterbi produces only valid state transitions, this is ok (i guess)
		stateState = zeros(Int,2^nShiftRegs,2^nShiftRegs)

		for i=0:3
			temp = nState[i+1,:]
			for j=0:3
				ind = findall(x->x==j, temp)
				if(!isempty(ind))
					stateState[i+1,j+1] = ind[1]-1 # also pretty ugly... when we find something, it has length 1
				end
			end
		end



		# output matrix
		# dim-1 = current state
		# dim-2 = input
		# dim-3 = select output (polynomial 1, 2...)
		outp = zeros(Int, 2^nShiftRegs, 2, 2)
		for i=0:2^nShiftRegs-1
			for gi = 1:K
				currentG = g[gi]
				# the polynomials take an input value which consists of the input and the shift register
				temp = (i << 1) | 0
				o = xoritall(temp & currentG, nShiftRegs+1)
				outp[i+1, 1, gi] = o

				temp = (i << 1) | 1
				o = xoritall(temp & currentG, nShiftRegs+1)
				outp[i+1, 2, gi] = o
			end
		end
		new(g, K, nShiftRegs, nState, pState, stateState, outp)
	end
end


# xor the lower len bits of x
function xoritall(x, len)
	res = 0
	for i=0:len-1
		tmp = (x >> i) & 1
		res = xor(res, tmp)
	end
	res
end


function encode(cc::ConvCode, inf_bits)
	nState = cc.nState
	outp = cc.outP
	curState = 1
	res = zeros(Int, 2*length(inf_bits))
	for k=1:length(inf_bits)
		ot = outp[curState, 1+inf_bits[k],:]
		res[2*k-1:2*k] = ot
		curState = 1+nState[curState, 1+inf_bits[k]]
	end
	res
end


g1 = 0o5
g2 = 0o7


c = ConvCode([g1, g2])

# inf_bits = [1,0,0,0,0,0,0]
inf_bits = [1,1,0,0,1,0,1,0]
code_bits = encode(c, inf_bits)


# viterbi - beginning
function viterbi(c::ConvCode, r)
	# initialization
	pMetric = [0 1000 1000 1000] # metric initialization. start state = 0 -> initial metric = 0; all other metrics = "infinity" 
	paths = [[], [], [], []] # for every state we initialize an empty array

	Nrseq = length(rseq)

	for time = 1:2:Nrseq # run through the sequence of received bits

		r = rseq[time:time+1] # the received code bits at time t
		#@show r
		tempMetric = copy(pMetric) # copy the current metric away. in the following loop, we update tempMetric
		tempPaths = deepcopy(paths) # copy the current paths away. since it is an array of arrays, we need(?) to use deepcopy

		for cState = 0:2^c.nShiftRegs-1 # the current state
			#@show cState

			pState = c.pState[cState+1,:] # the previous states leading into cState
			#@show pState
			curpState = pState[1] # select option 1 for previous state
			#@show curpState
			if(c.nState[curpState+1,1] == cState) # an inf.bit=0 caused the state transition
				cw = c.outP[curpState+1,1,:]
			else # an inf.bit=1 cause the state transition
				cw = c.outP[curpState+1,2,:]
			end
			#@show cw
			metric_update = sum(abs.(cw - r)) # calculate the metric update
			#@show metric_update
			cand_1 = pMetric[curpState+1] + metric_update # and calculate an updated metric
			#@show cand_1

			curpState = pState[2] # select option 2 for previous state
			#@show curpState
			if(c.nState[curpState+1,1] == cState) # an inf.bit=0 caused the state transition
				cw = c.outP[curpState+1,1,:]
			else # an inf.bit=1 cause the state transition
				cw = c.outP[curpState+1,2,:]
			end
			#@show cw
			metric_update = sum(abs.(cw - r))
			#@show metric_update
			cand_2 = pMetric[curpState+1] + metric_update
			#@show cand_2

			if(cand_1 < cand_2) # choose candidate1 path
				temp = deepcopy(paths[pState[1]+1]) # path to previous state
				append!(temp, pState[1]) # append chosen previous state
				tempPaths[cState+1] = temp # update the path
				tempMetric[cState+1] = cand_1
			else
				#println("choose cand_2")
				temp = deepcopy(paths[pState[2]+1])
				append!(temp, pState[2])
				tempPaths[cState+1] = temp
				tempMetric[cState+1] = cand_2
			end
		end

		pMetric = copy(tempMetric) # copy back the metric
		paths = deepcopy(tempPaths) # copy back the paths
		
	end
	#@show pMetric
	#@show paths

	_, ind = findmin(pMetric) # find the minimum metric
	resPath = paths[ind[2]] # and corresponding path
	append!(resPath, ind[2]-1)
	#@show resPath

	inf_bits_hat = zeros(Int, convert(Int, Nrseq/2))

	for i=1:length(resPath)-1 # now run through the state transitions
		ps = resPath[i]
		ns = resPath[i+1]
		#@show ps, ns
		inf_bits_hat[i] = c.stateState[ps+1, ns+1] # and re-obtain the inf bit sequence
	end
	inf_bits_hat
end


rseq = [1,1, 1,0, 0,0, 1,0, 1,1, 0,1, 0,0, 0,1]
ss = viterbi(c, rseq)


