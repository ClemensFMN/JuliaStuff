using Flux

# using Flux.Tracker: param, back!, grad, update!, train!
using Random

# https://github.com/FluxML/model-zoo/blob/master/tutorials/60-minute-blitz.jl

ktrue = 1.2
dtrue = 0.4

x = [0,1,2,3,4]
y = ktrue .* x .+ dtrue


m = Dense(1,1)

loss(x,y) = Flux.mse(m(x), y)
# opt = SGD(params(m), 0.01)
# opt()
opt = Descent(0.1)

training_data = collect(zip(x,y))

# Flux.train!(loss, training_data, opt)
Flux.train!(loss, params(m), training_data, opt)
