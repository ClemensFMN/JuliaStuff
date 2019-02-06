using LinearAlgebra
using Flux.Tracker
using Random
using Plots
plotly()

# same as lin_reg_1.jl, but using Flux framework...



Random.seed!(0)

# model order
M = 3

a = rand(M,1)


# define the prediction function for any model order
predict(x) = a[1] .+ a[2]*x + a[3]*x.^2# .+ a[4]*x.^4
# for whatever reasons this does not work... Produces the same value as predict above, but it seems that automatic differentiation does not work
predict2(x) = sum([a[i].*x.^(i-1) for i=1:M])

# and loss function
function loss(x,y)
  yhat = predict(x)
  sum((y .- yhat).^2)
end

# get some data
x = [-2.0,-1.0,0.0,1.0,2.0]
y = 1.3 .- 0.5*x # .+ 0.2*x.^2


# define a as Flux parameter
a = param(a)

# implement gradient descent by calculating the gradient, updating a and start again
for i=1:200
  # now calculate the gradient of the loss function
  gs = Tracker.gradient(() -> loss(x,y), Params([a]))
  # obtain the gradient wrt a and update a
  deltaa = gs[a]
  Tracker.update!(a, -0.01*deltaa)
  # print some status message
  println(i, a, loss(x,y))
end

#plot(x,y)
#plot!(x, Tracker.data(predict(x)))

# solution via pseudo-inverse
Xmat = [x.^2 x [1,1,1,1,1]]
ahat = pinv(Xmat)*y
println(ahat)