# Import packages
using Turing
using StatsPlots

alpha = 1
beta = 2
n = 10
p = 0.3

# Define a simple Gaussian model with unknown mean (having uniform prior) and known variance
@model my_model(y) = begin
  p ~ Beta(alpha, beta)
  y ~ Binomial(n, p)
  return y
end

k = 2
c = sample(my_model(k), HMC(10000, 0.1, 5))
# c = sample(normal_demo(0.5), SMC(1000))

#(k + alpha)/(n + alpha + beta)
# (k + alpha -1)/(n + alpha + beta - 2)