using Distributions
# using SpecialFunctions
using Plots
plotly()


N = 500_000


SNRvec = 0:10:100 #-8:2:10
sw2vec = 10 .^ (-SNRvec ./ 10)

bdist = Bernoulli(0.5)
hdist = Normal(0, 1)

BER = zeros(length(SNRvec))
BERanalytic = zeros(length(SNRvec))

for snr_iter = 1:length(SNRvec)

	sw2 = sw2vec[snr_iter]
	wdist = Normal(0, sqrt(sw2))

	b = rand(bdist, N)
	x = 2*b.-1

	bhat = zeros(N)
	h = rand(hdist, N) #ones(N)
	y = h .* x .+ rand(wdist, N)
	r = y .* h
	bhat = sign.(r)

	errs = length(findall(bhat.!=x))
	println(SNRvec[snr_iter])
	BER[snr_iter] = errs/N
	BERanalytic[snr_iter] = sqrt( sqrt(2*sw2) / (sqrt(2) + 2*sw2)) # 0.5*erfc(1 / sqrt(2*sw2)) # 0.5*(1 + erf(-1/sqrt(2*sw2)))

end

# [BER BERanalytic]
plot(SNRvec, BER, yscale=:log10)
plot!(SNRvec, BERanalytic, yscale=:log10)


