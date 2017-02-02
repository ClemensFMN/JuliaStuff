using Mamba

N = 5
sw2 = 0.1

model = Model(

    y = Stochastic(1,(x) -> MvNormal(x*ones(N), sqrt(sw2)*eye(N)) ),
    # sw2 = Logical( () -> 1), - does NOT work...
    x = Stochastic( () -> Normal(0,1))

)

scheme = [NUTS(:x)]

setsamplers!(model, scheme)

draw(model)

line = Dict{Symbol, Any}(
  :y => [1, 1, 1, 1, 1]
)

inits = [
  Dict{Symbol, Any}(
     :y => line[:y],
     :x => rand(Normal(0,1)))]

sim = mcmc(model, line, inits, 5000, burnin=200, thin=2, chains=1)

describe(sim)
