using Flux
using Random
using Plots
plotly()

ktrue = 1.2
dtrue = -0.7

ground_truth(x) = ktrue * x .+ dtrue

N = 1_000

x_train = 5 .* rand(N)
y_train = ground_truth(x_train) .+ 0.05 .* randn(1)


model(x) = k*x .+ d

k = rand(1)
d = rand(1)

function loss(x, y)
  yhat = model(x)
  sum((y .- yhat).^2)
end

opt = Descent(0.01)


train_data = zip(x_train, y_train)
ps = params(k, d)

for (x,y) in train_data
  gs = Flux.gradient(ps) do
    loss(x,y)
  end
  Flux.Optimise.update!(opt, ps, gs)
end

@show k, d



#m = Dense(1,1)

#loss(x,y) = Flux.mse(m(x), y)
# opt = SGD(params(m), 0.01)
# opt()
#opt = Descent(0.1)

#training_data = collect(zip(x,y))

# Flux.train!(loss, training_data, opt)
#Flux.train!(loss, params(m), training_data, opt)
