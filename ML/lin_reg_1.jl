# https://fluxml.ai/Flux.jl/stable/models/basics/

using Flux.Tracker
using Flux.Tracker: update!
using Random

Random.seed!(0)


k = rand(1,1)
d = rand(1,1)

#println(k,d)

predict(x) = k.*x .+ d

function loss(x, y)
  ŷ = predict(x)
  sum((y .- ŷ).^2)
end



x = [0, 1, 2, 3]
y = 0.2*x .+ 0.5# + 0.01*randn(4,1)

k = param(k)
d = param(d)


for i=1:500
  gs = Tracker.gradient(() -> loss(x, y), Params([k]))
 
  deltak = gs[k]
  update!(k, -0.01*deltak)
  deltad = gs[d]
  update!(d, -0.01*deltad)

  #println(deltak)#, deltad)

  println(i,k,d, loss(x,y))
end