using Flux
using Flux.Tracker
using Random

Random.seed!(0)

k = rand()
d = rand()

# define k and d as Flux parameters
k = param(k)
d = param(d)


# define the prediction function
predict(x) = k .* x .+ d

# and loss function
loss(x,y) = Flux.mse(predict(x), y)

# get some data
x = [0,1,2,3]
y = 0.2*x .+ 0.5

ps = params(k,d)

gloss = Tracker.gradient(() -> loss(x,y), ps)

opt = Descent(0.1)

data = collect(zip(x,y))


for run = 1:50

  # Tracker.update!(opt, ps, gloss)

  for p in ps
     Tracker.update!(p, -0.01 *gloss[p])
  end

  println(run, "..", loss(x,y), k, d, gloss[k], gloss[d])

end


# Flux.train!(loss, params(k,d), data, opt)
