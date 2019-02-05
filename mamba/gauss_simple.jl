using Mamba
using LinearAlgebra


N = 5
sw2 = 0.1
sx2 = 1

model = Model(
    # I THINK, this is a bit mean here as MvNormal requires sw2
    # y = Stochastic(1,(x) -> MvNormal(x*ones(N), sw2*eye(N)) ),
    y = Stochastic(1,(x) -> MvNormal(x*ones(N), sw2 * Matrix{Float64}(I, N, N))),
    # sw2 = Logical( () -> 1), - does NOT work...
    # but Normal takes \sigma_x and NOT \sigma_x^2
    x = Stochastic( () -> Normal(0,sqrt(sx2)))

)

scheme = [NUTS(:x)]

setsamplers!(model, scheme)

draw(model)

line = Dict{Symbol, Any}(
  :y => ones(N) # [1, 1, 1, 1, 1]
)

inits = [
  Dict{Symbol, Any}(
     :y => line[:y],
     :x => rand(Normal(0,1)))]

sim = mcmc(model, line, inits, 10000, burnin=1000, thin=2, chains=1)

describe(sim)



# analytical solution
pos_mean = sx2 / (sw2 + N*sx2) * N
println(pos_mean)

post_var = sx2*sw2 / (sw2 + N*sx2)
println(post_var, "   ", sqrt(post_var))
