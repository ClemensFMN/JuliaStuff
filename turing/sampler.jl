# Import libraries.
using Turing, StatsPlots, Random


@model gdemo_1(x, y) = begin
  s ~ InverseGamma(2,3)
  m ~ Normal(0,sqrt(s))
  x ~ Normal(m, sqrt(s))
  y ~ Normal(m, sqrt(s))
  return x, y
end

@model gdemo_2(u) = begin
  u ~ Uniform(0,1)
  return u
end



# Samples from p(x,y)
#g_prior_sampler_1 = gdemo_1()
#g_prior_sampler_1()


g_prior_sampler_2 = gdemo_2()
g_prior_sampler_2()

