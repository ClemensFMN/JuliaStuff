using Flux



d1 = Dense(5,2) # creates a dense layer with y = sigma(W * x .+ b)

x = randn(5)

res1 = d1(x)
res2 = d.W * x .+ b # same



#d2 = Chain(Dense(5,2), softmax)


