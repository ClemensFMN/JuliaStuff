using Distributions

N = int(1e5)
L = 1

SNRvec = -10:2:6
sw2vec = 10.^(-SNRvec/10)


BER = zeros(length(SNRvec))

for snr_iter = 1:length(SNRvec)

	sw2 = sw2vec[snr_iter]

	bdist = Bernoulli(0.5)

	b = rand(bdist, N)

	x = 2*b-1

	hdist = Normal(1, 0.001)
	wdist = Normal(0, sw2)

	bhat = zeros(N)

	for i = 1:N

		h = rand(hdist, L)
		y = h * x[i] + rand(wdist,L)
		r = y'*h
	
		bhat[i] = sign(r[1])

	end

	errs = 0

	for i = 1:N
		if(bhat[i] != x[i])
			errs = errs+1
		end
	end

	println(errs/N)
	BER[snr_iter] = errs/N

end

print(BER)

writedlm("L1.csv", [SNRvec BER])

