using Flux


m = Chain(Dense(10, 5, relu), Dense(5, 2), softmax)

opt = SGD(params(m), 0.01)
opt() # updates the weights

# `Training` a network reduces down to iterating on a dataset mulitple times, performing these
# steps in order. Just for a quick implementation, let’s train a network that learns to predict
# `0.5` for every input of 10 floats. `Flux` defines the `train!` function to do it for us.

data, labels = rand(10, 100), fill(0.5, 2, 100)
# loss(x, y) = sum(Flux.crossentropy(m(x), y))
loss(x, y) = sum(Flux.mse(m(x), y))

Flux.train!(loss, [(data,labels)], opt) # deprecated, but works...
