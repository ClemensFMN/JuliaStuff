using Flux.Tracker
using Random

# same as lin_reg_1.jl, but using Flux framework...



Random.seed!(0)

k = rand(1,1)
d = rand(1,1)

# define the prediction function
predict(x) = k.*x .+ d

# and loss function
function loss(x,y)
  yhat = predict(x)
  sum((y .- yhat).^2)
end

# get some data
x = [0,1,2,3]
y = 0.2*x .+ 0.5

# define k and d as Flux parameters (I assume then we can use them in a gradient expression as further below)
k = param(k)
d = param(d)

# implement gradient descent by calculating the gradient, updating k and d and start again
for i=1:500
  # now calculate the gradient of the loss function
  gs = Tracker.gradient(() -> loss(x,y), Params([k,d]))
  # obtain the gradient wrt k and update k with it
  deltak = gs[k]
  Tracker.update!(k, -0.01*deltak)
  # same for parameter d
  deltad = gs[d]
  deltad = gs[d]
  Tracker.update!(d, -0.01*deltad)
  # print some status message
  println(i, k, d, loss(x,y))
end

