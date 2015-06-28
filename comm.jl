using Distributions

N = int(1e6)
L = 1

SNRvec = -10:4:20
sw2vec = 10.^(-SNRvec/10)

bdist = Bernoulli(0.5)
hdist = Normal(0, 1)

BER = zeros(length(SNRvec))

for snr_iter = 1:length(SNRvec)

	sw2 = sw2vec[snr_iter]
	wdist = Normal(0, sw2)

	b = rand(bdist, N)
	x = 2*b-1

	bhat = zeros(N)

	for i = 1:N

		h = rand(hdist, L)
		y = h * x[i] + rand(wdist,L)
		r = y'*h
	
		bhat[i] = sign(r[1])

	end

	errs = length(find(bhat.!=x))

	println(errs/N)
	BER[snr_iter] = errs/N

end

print(BER)

writedlm("L$L.csv", [SNRvec BER])

