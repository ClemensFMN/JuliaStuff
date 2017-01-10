using Distributions

p = 0.45
n = 20
a = 0.75

RUNS = convert(Int, 1e6)

dist = Bernoulli(p)

cnt = zeros(RUNS)

for iter in 1:RUNS

    xvec = rand(dist, n)

    s = sum(xvec)

    # exact n*a ones in the random vector
    cnt[iter] = (s == n*a)
    # more ones than n*a
    #cnt[iter] = (s > n*a)

end

println(sum(cnt) / RUNS)

# if we seek the probability of having exactely n*a ones in the vector, we can do this via
naint = convert(Int, n*a)
println(binomial(n, naint)*p^(naint)*(1-p)^(n-naint))