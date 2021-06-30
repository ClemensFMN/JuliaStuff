# Import packages
using Turing
using StatsPlots

# Define a Gaussian model with unknown mean and unknown variance
@model model(y) = begin
  s ~ Uniform(1.0,50.0) # careful, the thing is a bit picky that the variance > 0
  mu ~ Normal(160,20)

  N = length(y) # we have N observations

  for n in 1:N
     y[n] ~ Normal(mu, s) # and therefore need to define how these observations come into being...
  end
end

# our 4 observations
obs = [180, 190, 185, 187]

# mean(obs) -> 185.5


# it seems that the HMC sampler does not converge
# c = sample(model([180, 175]), HMC(0.1, 5), 5000)
# c = sample(model([180, 175, 172, 181]), HMC(0.1, 5), MCMCThreads(), 5000, 4)
# the NUTS sampler, however does converge...

# sampling from the prior - does not work :-(
# c = sample(model, Prior, 5000)
# sampling from the prior
cprior = sample(model([]), NUTS(), MCMCThreads(), 5000, 4)

# sampling from the posterior
c = sample(model(obs), NUTS(), MCMCThreads(), 5000, 4)


#plotly()
#plot(c)

# RESULTS

# mu ~ Normal(160,20)

#Quantiles
#  parameters       2.5%      25.0%      50.0%      75.0%      97.5% 
#      Symbol    Float64    Float64    Float64    Float64    Float64 
#
#           s     2.6933     4.3407     6.0833     9.2320    25.8057
#          mu   172.5782   182.5543   184.8214   186.7366   191.6806

# now we are very sure about the mu prior. Therefore, the observations are considered less relevant & the posterior 
# for mu lies closely around the 160. In order to explain the large deviation mu & observation, the posterior for
# s is rather large...
#  mu ~ Normal(160,2)

#Quantiles
#  parameters       2.5%      25.0%      50.0%      75.0%      97.5% 
#      Symbol    Float64    Float64    Float64    Float64    Float64 
#
#           s    15.6926    23.1691    29.4858    37.0043    48.2871
#          mu   156.5787   159.2338   160.5862   161.9353   164.4847



c

