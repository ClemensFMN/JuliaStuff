include("cc_start.jl")
using Distributions

# convcode simulation over an AWGN channel
# compare with /home/clnovak/src/cpp/IT++Stuff/ConvCodes/
# and this simulation performs slightly worse than the C++ version
# e.g. SNR = 3db
# BER = [0.00388359] with this script
# BER =  0.00348648
# I don't know why, noise variance seems to be correct (quite tricky to set up), we 
# use a gaussian metric in cc_start and I think the viterbi is correctly 
# implemented (at least in the BSC case it )

SNRdB = 3 #0:2:20
sw2vec = 1/(2*1/2) * 10 .^ (-SNRdB / 10) # that's the noise power per transmitted bit. something is maybe wrong here?

N = 5
RUNS  = 1000 #5000
#g1 = 0o31
#g2 = 0o27
#g1 = 0o13
#g2 = 0o17
g1 = 0o5
g2 = 0o7


c = ConvCode([g1, g2])

err_i = zeros(length(SNRdB), RUNS)


for (ind, sw2) in enumerate(sw2vec)

	@show sw2
	ndist = Normal(0, sqrt(sw2)) # Careful: Normal requires the sqrt of sw2

	for i in 1:RUNS
		inf_bits = rand(0:1, N)
		#inf_bits[N-10:N] = zeros(11) # zero padding
		code_bits = encode(c, inf_bits)# encoding
		s = 2 * code_bits .- 1 # BPSK modulation: 0 -> -1, 1 -> 1
	# @show s
		rec_syms = s + rand(ndist, 2*N) # AWGN channel
	# @show rec_syms
		code_bits_demod = (rec_syms .+ 1)/2 # "soft" demodulation
		inf_bits_hat = viterbi_awgn(c, code_bits_demod) # feeding the soft bits into the viterbi decoder. Since it is BPSK, this works

		err_i[ind, i] = sum(abs.(inf_bits-inf_bits_hat)) / length(inf_bits)
	end

end

println(mean(err_i,dims=2))
