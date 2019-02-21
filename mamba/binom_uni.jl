using Mamba
using LinearAlgebra
using Plots
plotly()

N = 1


model = Model(
    y = Stochastic(1, (p) -> Binomial(N, p)),
    p = Stochastic( () -> Uniform()))


scheme = [NUTS(:p)]

setsamplers!(model, scheme)

draw(model)


line = Dict{Symbol, Any}(
  :y => [1]
)


inits = [
  Dict{Symbol, Any}(
     :y => line[:y],
     :p => 0.5)]

sim = mcmc(model, line, inits, 20000, burnin=1000, thin=2, chains=1)

describe(sim)


histogram(sim.value[:,1], bins=50)
