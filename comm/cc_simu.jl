include("cc_start.jl")
using Distributions


cross_over_probs = range(0.1, stop=0.01, length=10)

N = 256
RUNS  = 50
g1 = 0o64 #0o5
g2 = 0o74 #0o7
c = ConvCode([g1, g2])

err_i = zeros(length(cross_over_probs), RUNS)
err_c = zeros(length(cross_over_probs), RUNS)


for (ind, p) in enumerate(cross_over_probs)

	pdist = Bernoulli(p)

	for i in 1:RUNS
		inf_bits = rand(0:1, N)
		inf_bits[N-10:N] = zeros(11) # zero padding
		code_bits = encode(c, inf_bits)
		rec_bits = xor.(code_bits, rand(pdist, 2*N))
		inf_bits_hat = viterbi_2(c, rec_bits)

		err_c[ind, i] = sum(abs.(code_bits-rec_bits)) / length(code_bits)
		err_i[ind, i] = sum(abs.(inf_bits-inf_bits_hat)) / length(inf_bits)
	end

end

println(mean(err_c,dims=2))
println(mean(err_i,dims=2))
