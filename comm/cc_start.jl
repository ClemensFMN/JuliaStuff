# convolutional code functions

mutable struct ConvCode
	g 	# code polynomials - CAREFUL: they are stored as ints and NOT OCTALs!!
	K   # number of output streams
	nState # next state matrix - see below
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
		new(g, K, nState, outp)
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

inf_bits = [1,0,0,0,0,0,0]
code_bits = encode(c, inf_bits)


