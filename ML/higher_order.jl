using Flux
using Random
using Plots
plotly()

a2 = 1.2
a1 = -3.4
a0 = 1.4

ground_truth(x) = a2 .* x.^2 .+ a1 .* x .+ a0

N = 1_000

x_train = randn(N)
y_train = ground_truth(x_train) .+ 0.05 .* randn(N)

# scatter(x_train, y_train)

# layer1 = 1-d input, 16-d output + relu
# layer2 = 16-d input, 1-d input
model = Chain(Dense(1, 16, relu), Dense(16, 1))


function loss(x, y)
  yhat = model([x])
  sum((y .- yhat).^2)
end

opt = Descent(0.01)


train_data = zip(x_train, y_train)
ps = params(model)

epochs = 10

for epoch = 1:epochs
  for (x,y) in train_data
    gs = Flux.gradient(ps) do
      loss(x,y)
    end
  Flux.Optimise.update!(opt, ps, gs)
  end
end

x_pred = -3:0.1:3
y_pred = [model([x])[1] for x in x_pred]

scatter(x_train, y_train)
scatter!(x_pred, y_pred)
