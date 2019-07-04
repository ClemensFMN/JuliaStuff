using Distributions

# estimate mean and variance of a normal RV from N samples

mu = 2
s = 0.5

p = Normal(2, s)

RUNS = 100_000


N = 5

s2_hat = zeros(RUNS)
S_hat = zeros(RUNS)

for ind = 1:RUNS
	x = rand(p, N) # random values
	mu_hat = mean(x) # sample mean

	a = 1/N * sum((x .- mu_hat).^2) # biased variance estimator
	b = 1/(N-1) * sum((x .- mu_hat).^2) # unbiased one

	s2_hat[ind] = a
	S_hat[ind] = b
end

println(mean(s2_hat)) # mean across runs
println(mean(S_hat))

println(s^2)
println(s^2*(N-1)/N)
