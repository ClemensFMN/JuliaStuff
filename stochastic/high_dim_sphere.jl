using Distributions
using Plots
plotly()



# generate random points on the unit sphere with uniform disribution
# https://stats.stackexchange.com/questions/7977/how-to-generate-uniformly-distributed-points-on-the-surface-of-the-3-d-unit-sphe


# for D = 3, the following link shows that the expected value of dists is 4/3
# http://godplaysdice.blogspot.com/2011/12/solution-to-distance-between-random.html

# for D = 2

D = 10
Num = 1000

samples = zeros(D, Num)

N = Normal(0,1)


for i in 1:Num
  x = rand(N, D)
  lambda = norm(x)

  samples[:,i] = x / lambda

end


# scatter(samples[1,:], samples[2,:])


dists = Float64[]
dotprod = Float64[]

for i1 = 1:Num
  for i2 = i1+1:Num
    #d = norm(samples[:,i1] - samples[:,i2])
    #append!(dists, d)

    d2 = norm(samples[:,i1] - samples[:,i2]).^2
    append!(dists, d2)

    dtprd = dot(samples[:,i1], samples[:,i2])
    append!(dotprod, dtprd)
  end
end

# histogram(dists, nbins=100)



