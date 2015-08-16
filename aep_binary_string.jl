using Winston

# number of bits
N = 50
# prob of a one
pbit = 0.1


kvec = 0:N
p = zeros(N+1)


for k = kvec
	# calculating the prob of a binary word length N with k ones
	p[k+1] = binomial(N,k) * pbit^k * (1-pbit)^(N-k)
end

# the prob peaks at pbit x N

plot(kvec, p)

savefig("aep_binary_string.png")
