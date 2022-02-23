using Flux



d1 = Dense(3,2) # creates a dense layer with y = W * x .+ b

x = randn(3)

res1 = d1(x)
res2 = d1.weight * x .+ d1.bias # same

@show res1, res2

@show params(d1)

loss(x) = Flux.Losses.mse(d1(x) , [0.5, 0.5])

grads = gradient(params(d1)) do
    loss(x)
end
for p in params(d1)
    @show p, grads[p]
end

