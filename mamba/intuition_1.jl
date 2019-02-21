using Mamba
using LinearAlgebra

sx2 = 0.001


model = Model(
    y = Stochastic(1, (x) -> Normal(x, sqrt(sx2))),
    x = Stochastic(() -> Uniform())
)

scheme = [NUTS(:x)]
setsamplers!(model, scheme)
draw(model)


line = Dict{Symbol, Any}(
  :y => [2.0]
)

inits = [
  Dict{Symbol, Any}(
     :y => line[:y],
     :x => 0.5)]

sim = mcmc(model, line, inits, 10000, burnin=1000, thin=2, chains=1)

describe(sim)
