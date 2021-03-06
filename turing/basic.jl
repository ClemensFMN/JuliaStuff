# Import packages
using Turing
using StatsPlots

# Define a simple Gaussian model with unknown mean (having uniform prior) and known variance
@model normal_demo(y) = begin
  m ~ Uniform(0,1)
  y ~ Normal(m, 0.1)
  return y
end


c = sample(normal_demo(0.5), HMC(0.1, 5), 1000)
# c = sample(normal_demo(0.5), SMC(1000))

print(c)

#ms = c[:m]
#ms.value


plotly()
plot(c)

