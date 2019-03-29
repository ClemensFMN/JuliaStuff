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
# implemented (second version performs the same)
# especially in case of shorter blocks, the implementations perform worse
# SNRdB = 3
# N =  32 -> BER = 0.0072875  (IT++: 0.00315094)
# N =  64 -> BER = 0.00553438 (IT++: 0.00332781)
# N = 256 -> BER = 0.00380469 (IT++: 0.00345687)
# SOLUTION
# The encoder truncates; i.e. the last info bits would affect code bits "after" N but these are cut off
# therefore, these info bits have less error protection
# in other words, the BER is smaller at positions in the beginning and increases towards the end of the transmitted info block
# in case of short block lengths, the percentage of bad bits at the end is higher than in case of large block lengths
# -> in case of small N, the BER is higher
# in IT++, the encoder is appending so many zeros after the info bits that the encoder ends in state 0 & transmits more code bits
# AND the viterbi takes this zero end-state into account
# this is not done here...
# for N = 2046, the BER is 0.00330078 \approx the IT++ result from above

SNRdB = 3 #0:2:20
sw2vec = 1/(2*1/2) * 10 .^ (-SNRdB / 10) # that's the noise power per transmitted bit. something is maybe wrong here?

N = 2048
RUNS  = 100#5000
#g1 = 0o31
#g2 = 0o27
#g1 = 0o13
#g2 = 0o17
g1 = 0o5
g2 = 0o7


c = ConvCode([g1, g2])

err_i = zeros(length(SNRdB), RUNS)
err_i_2 = zeros(length(SNRdB), RUNS)


for (ind, sw2) in enumerate(sw2vec)

	@show sw2
	ndist = Normal(0, sqrt(sw2)) # Careful: Normal requires the sqrt of sw2

	for i in 1:RUNS
		inf_bits = rand(0:1, N)
#@show inf_bits
		#inf_bits[N-10:N] = zeros(11) # zero padding
		code_bits = encode(c, inf_bits)# encoding
		s = 2 * code_bits .- 1 # BPSK modulation: 0 -> -1, 1 -> 1
	# @show s
		rec_syms = s + rand(ndist, 2*N) # AWGN channel
	# @show rec_syms
		code_bits_demod = (rec_syms .+ 1)/2 # "soft" demodulation
		inf_bits_hat = viterbi_awgn(c, code_bits_demod)  # both viterbi implementations perform the same...
		inf_bits_hat_2 = viterbi_awgn_2(c, code_bits_demod)
#@show inf_bits_hat
		#err_i[ind, i] = sum(abs.(inf_bits-inf_bits_hat)) / length(inf_bits)
		err_i_2[ind, i] = sum(abs.(inf_bits-inf_bits_hat_2)) / length(inf_bits)
# @show findall(x->x != 0, inf_bits-inf_bits_hat_2)
	end

end

println(mean(err_i,dims=2))
println(mean(err_i_2,dims=2))
