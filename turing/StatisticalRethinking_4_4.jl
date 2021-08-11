# Import packages
using Turing
using StatsPlots
using Plots
plotly()
# using Distributions

# we have a model y = kx + d + w
# with k \sim N(1,1), d \sim N(0,1), w \sim N(0,1)
# x \sim N(10,10)

# Define a Gaussian model with unknown mean and unknown variance
@model model(x, y) = begin
  k ~ Normal(1,1)
  d ~ Normal(0,1)

  N = length(y)

  for n in 1:N
     y_det = k*x[n] + d
     y[n] ~ Normal(y_det, .1)
  end
end


k_true = rand(Normal(1,1))
d_true = rand(Normal(0,1))

N = 100

obs_x = 0:1/N:1
obs_y = k_true*obs_x .+ d_true + rand(Normal(0, 0.1), (size(obs_x)))

c = sample(model(obs_x, obs_y), NUTS(), MCMCThreads(), 5000, 4)

print(k_true, "  ", d_true)


posterior_k = mean(c[:k])
posterior_d = mean(c[:d])

est_y = posterior_k * obs_x .+ posterior_d


#plot(obs_x, obs_y)
#plot!(obs_x, est_y)

# plot(c)



