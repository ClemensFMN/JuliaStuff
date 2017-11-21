using Distributions


mu = 1.5
s2 = 0.4

N = 100000

# just some basic checks
n = Normal(mu, sqrt(s2))
X = rand(n, N)

println(mean(X))
println("measured: ", mean(X.^2), " analytical: ", mu^2+s2)

# p = prob for value 1
p = 0.7

b = Bernoulli(p)
B = rand(b,N)


Z = X + B

println("measured: ", mean(Z), " analytical: ", (1-p)*mu + p*(mu+1))
println("measured: ", mean(Z.^2), " analytical: ", (1-p)*(mu^2+s2) + p*(s2 + (mu+1)^2))
