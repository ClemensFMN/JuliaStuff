# convolutional code functions

struct ConvCode
	g::Array{Int, 1} 	# code polynomials - CAREFUL: they are stored as ints and NOT OCTALs!!
	K::Int   # number of output streams
	nShiftRegs::Int # number of shift registers
	nState::Array{Int,2} # next state matrix - see below
	pState::Array{Int,2} # previous state matrix - see below
	stateState::Array{Int,2} # state-state transition - see below
	outP::Array{Int,3} # output matrix - see below
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
		for k=0:2^nShiftRegs-1
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

		for i=0:2^nShiftRegs-1
			temp = nState[i+1,:]
			for j=0:2^nShiftRegs-1
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






# viterbi decoder for AWGN channels
function viterbi_awgn(c::ConvCode, rseq)
	
	Nrseq = length(rseq)
	Niseq = convert(Int, floor(Nrseq/2))
	# initialization
	pMetric = [0 1000*ones(1,2^c.nShiftRegs-1)] # metric initialization. start state = 0 -> initial metric = 0; all other metrics = "infinity" 
	paths = zeros(Int, 2^c.nShiftRegs, Niseq+1) # for every state we initialize a zero vector. the time value (below) points to how far the vector is relevant


	for time = 1:Niseq # run through the sequence of received bits

		r = rseq[2*time-1:2*time] # the received code bits at time t
		#@show r
		tempMetric = copy(pMetric) # copy the current metric away. in the following loop, we update tempMetric
		tempPaths = copy(paths) # copy the current paths away

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
			#@show r
			#metric_update = sum(abs.(cw - r)) # calculate the metric update for BSC
			metric_update = sum((cw - r).^2) # calculate the metric update for AWGN
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
			#metric_update = sum(abs.(cw - r))
			metric_update = sum((cw - r).^2)
			#@show metric_update
			cand_2 = pMetric[curpState+1] + metric_update
			#@show cand_2

			if(cand_1 < cand_2) # choose candidate1 path
				#temp = deepcopy(paths[pState[1]+1]) # path to previous state
				#append!(temp, pState[1]) # append chosen previous state
				#tempPaths[cState+1] = temp # update the path
				temp = copy(paths[pState[1]+1,:])
				temp[time] = pState[1]
				tempPaths[cState+1,:] = temp
				tempMetric[cState+1] = cand_1
			else
				#println("choose cand_2")
				#temp = deepcopy(paths[pState[2]+1])
				#append!(temp, pState[2])
				#tempPaths[cState+1] = temp
				temp = copy(paths[pState[2]+1,:])
				temp[time] = pState[2]
				tempPaths[cState+1,:] = temp
				tempMetric[cState+1] = cand_2
			end
		end
		pMetric = copy(tempMetric) # copy back the metric
		paths = copy(tempPaths) # copy back the paths
	end
	_, ind = findmin(pMetric) # find the minimum metric
	resPath = paths[ind[2],:] # and corresponding path
	resPath[end] = ind[2]-1

	inf_bits_hat = zeros(Int, Niseq)

	for i=1:length(resPath)-1 # now run through the state transitions
		ps = resPath[i]
		ns = resPath[i+1]
		#@show ps, ns
		inf_bits_hat[i] = c.stateState[ps+1, ns+1] # and re-obtain the inf bit sequence
	end
	inf_bits_hat
end




# viterbi decoder for AWGN channels
function viterbi_awgn_2(c::ConvCode, rseq)
	
	Nrseq = length(rseq)
	Niseq = convert(Int, floor(Nrseq/2))
	# initialization
	pMetric = [0 1000*ones(1,2^c.nShiftRegs-1)] # metric initialization. start state = 0 -> initial metric = 0; all other metrics = "infinity" 
	paths = zeros(Int, 2^c.nShiftRegs, Niseq+1) # path[state,path over time]
	paths[:, 1] = 0:2^c.nShiftRegs-1 # we initialize the start poin of each path
#@show paths

	newpMetric = copy(pMetric) # copy the current metric. in the following loop, we update newMetric
	newPaths = copy(paths) # copy the current paths. in the following, we update newPaths and used paths


	for time = 1:Niseq # run through the sequence of received bits. The initial state is at time = 1, therefore @ time we augment the state with time+1
		r = rseq[2*time-1:2*time] # the received code bits at time t
		#@show r
		for cState = 0:2^c.nShiftRegs-1 # the current state
			pState = c.pState[cState+1,:] # the previous states leading into cState
			curpState = pState[1] # select option 1 for previous state
			if(c.nState[curpState+1,1] == cState) # an inf.bit=0 caused the state transition
				cw = c.outP[curpState+1,1,:]
			else # an inf.bit=1 cause the state transition
				cw = c.outP[curpState+1,2,:]
			end
			#metric_update = sum(abs.(cw - r)) # calculate the metric update for BSC
			metric_update = sum((cw - r).^2) # calculate the metric update for AWGN
			cand_1 = pMetric[curpState+1] + metric_update # and calculate an updated metric

			curpState = pState[2] # select option 2 for previous state
			if(c.nState[curpState+1,1] == cState) # an inf.bit=0 caused the state transition
				cw = c.outP[curpState+1,1,:]
			else # an inf.bit=1 cause the state transition
				cw = c.outP[curpState+1,2,:]
			end
			#metric_update = sum(abs.(cw - r))
			metric_update = sum((cw - r).^2)
			cand_2 = pMetric[curpState+1] + metric_update

			if(cand_1 < cand_2) # choose candidate1 path
				temp = copy(paths[pState[1]+1,1:time]) # copy the path ending in pState[1] into temp
				append!(temp, cState) # add the current state to the path (at time+1)
				newPaths[cState+1,1:time+1] = temp # and update the path leading to the current state
				newpMetric[cState+1] = cand_1 # update the metric
			else
				temp = copy(paths[pState[2]+1,1:time])
				append!(temp, cState)
				newPaths[cState+1,1:time+1] = temp
				newpMetric[cState+1] = cand_2
			end
		end
		pMetric = copy(newpMetric) # copy back the metric
		paths = copy(newPaths) # copy back the paths
		# @show time, paths, pMetric
	end
	# we are done - now find the minimum-metric path through the trellis
	_, ind = findmin(pMetric) # find the minimum metric
	resPath = paths[ind[2],:] # and corresponding path
	# @show resPath
	# follow the resulting path and collect the information bits which led to the corresponding state transfer
	inf_bits_hat = zeros(Int, Niseq)
	for i=1:length(resPath)-1
		ps = resPath[i]
		ns = resPath[i+1]
		# @show ps, ns
		inf_bits_hat[i] = c.stateState[ps+1, ns+1] # and re-obtain the inf bit sequence
	end
	inf_bits_hat
end




# viterbi decoder for AWGN channels, assuming the encoder ends in the zero state...
function viterbi_awgn_zeropad(c::ConvCode, rseq)
	
	Nrseq = length(rseq)
	Niseq = convert(Int, floor(Nrseq/2))
	# initialization
	pMetric = [0 1000*ones(1,2^c.nShiftRegs-1)] # metric initialization. start state = 0 -> initial metric = 0; all other metrics = "infinity" 
	paths = zeros(Int, 2^c.nShiftRegs, Niseq+1) # path[state,path over time]
	paths[:, 1] = 0:2^c.nShiftRegs-1 # we initialize the start poin of each path
#@show paths

	newpMetric = copy(pMetric) # copy the current metric. in the following loop, we update newMetric
	newPaths = copy(paths) # copy the current paths. in the following, we update newPaths and used paths


	for time = 1:Niseq # run through the sequence of received bits. The initial state is at time = 1, therefore @ time we augment the state with time+1
		r = rseq[2*time-1:2*time] # the received code bits at time t
		#@show r
		for cState = 0:2^c.nShiftRegs-1 # the current state
			pState = c.pState[cState+1,:] # the previous states leading into cState
			curpState = pState[1] # select option 1 for previous state
			# TODO: other idea - maybe simpler (requires no if)
			# inf_bit = c.stateState[curpState, cState]
			# cw = c.outP[curpState, inf_bit,:]

			if(c.nState[curpState+1,1] == cState) # an inf.bit=0 caused the state transition
				cw = c.outP[curpState+1,1,:]
			else # an inf.bit=1 cause the state transition
				cw = c.outP[curpState+1,2,:]
			end
			#metric_update = sum(abs.(cw - r)) # calculate the metric update for BSC
			metric_update = sum((cw - r).^2) # calculate the metric update for AWGN
			cand_1 = pMetric[curpState+1] + metric_update # and calculate an updated metric

			curpState = pState[2] # select option 2 for previous state
			if(c.nState[curpState+1,1] == cState) # an inf.bit=0 caused the state transition
				cw = c.outP[curpState+1,1,:]
			else # an inf.bit=1 cause the state transition
				cw = c.outP[curpState+1,2,:]
			end
			#metric_update = sum(abs.(cw - r))
			metric_update = sum((cw - r).^2)
			cand_2 = pMetric[curpState+1] + metric_update

			if(cand_1 < cand_2) # choose candidate1 path
				temp = copy(paths[pState[1]+1,1:time]) # copy the path ending in pState[1] into temp
				append!(temp, cState) # add the current state to the path (at time+1)
				newPaths[cState+1,1:time+1] = temp # and update the path leading to the current state
				newpMetric[cState+1] = cand_1 # update the metric
			else
				temp = copy(paths[pState[2]+1,1:time])
				append!(temp, cState)
				newPaths[cState+1,1:time+1] = temp
				newpMetric[cState+1] = cand_2
			end
		end
		pMetric = copy(newpMetric) # copy back the metric
		paths = copy(newPaths) # copy back the paths
		# @show time, paths, pMetric
	end
	# we are done - select the path ending in state zero
	resPath = paths[1,:]
	# @show resPath
	# follow the resulting path and collect the information bits which led to the corresponding state transfer
	inf_bits_hat = zeros(Int, Niseq)
	for i=1:length(resPath)-1
		ps = resPath[i]
		ns = resPath[i+1]
		# @show ps, ns
		inf_bits_hat[i] = c.stateState[ps+1, ns+1] # and re-obtain the inf bit sequence
	end
	inf_bits_hat
end



#g1 = 0o5
#g2 = 0o7
#c = ConvCode([g1, g2])

# inf_bits = [1,0,0,0,0,0,0]
#inf_bits = [1,1,0,0,1,0,1,0,0,0,0]
#code_bits = encode(c, inf_bits)
	
# rseq = [1,1, 1,0, 0,0, 1,0, 1,1, 0,1, 0,0, 0,1] # example from book
#rseq = code_bits
# ss1 = viterbi(c, rseq)
#ss2 = viterbi(c, rseq)

# using Profile
# using ProfileView

# performance fun
# function perf1(N)
# 	g1 = 0o5
# 	g2 = 0o7
# 	c = ConvCode([g1, g2])
# 	inf_bits = rand(0:1, N)
# 	@time code_bits = encode(c, inf_bits)
# 	# @time viterbi(c, code_bits)
# 	@time inf_bits_hat = viterbi_2(c, code_bits)
# 	sum(abs.(inf_bits-inf_bits_hat))
# end

# perf1()
# Profile.clear()
# @profile perf1()
# ProfileView.view()
