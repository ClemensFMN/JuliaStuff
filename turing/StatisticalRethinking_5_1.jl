using Turing
using StatsPlots
using Distributions


@model model_5_1(div, age) = begin
  a ~ Normal(0,0.2)
  bA ~ Normal(0, 0.5)
  sigma ~ Exponential(1)

  N = length(div)

  for n in 1:N
     div[n] ~ Normal(a + bA * age[n], sigma)
  end
end

@model model_5_2(div, mar) = begin
  a ~ Normal(0,0.2)
  bM ~ Normal(0, 0.5)
  sigma ~ Exponential(1)

  N = length(div)

  for n in 1:N
     div[n] ~ Normal(a + bM * mar[n], sigma)
  end
end

@model model_5_3(div, age, mar) = begin
  a ~ Normal(0,0.2)
  bA ~ Normal(0, 0.5)
  bM ~ Normal(0, 0.5)
  sigma ~ Exponential(1)

  N = length(div)

  for n in 1:N
     div[n] ~ Normal(a + bA * age[n] + bM * mar[n], sigma)
  end
end



N = 1000
d_age = Normal()
d_mar = Normal()
d_div = Normal()

age_obs = rand(d_age, N)
mar_obs = rand(d_mar, N) .- age_obs
div_obs = rand(d_div, N) .+ age_obs

# sampling from the posterior
c_5_1 = sample(model_5_1(div_obs, age_obs), NUTS(), MCMCThreads(), 5000, 4)
c_5_2 = sample(model_5_2(div_obs, mar_obs), NUTS(), MCMCThreads(), 5000, 4)
c_5_3 = sample(model_5_3(div_obs, age_obs, mar_obs), NUTS(), MCMCThreads(), 5000, 4)

