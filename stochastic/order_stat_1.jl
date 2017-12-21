using Distributions
using Plots
plotly()
using StatsBase


# we consider a normal distribution
s2 = 1.5
#p = Normal(0,sqrt(s2))
p = Uniform()

kmax = 10
k = 1

N = 500000
edges = linspace(-2,2,50)

x = rand(p, kmax, N)

# sort column-wise
x = sort(x,1)

# and take the maximum of k samples; i.e. the k-th order statistics
res = x[k,:]
hres = fit(Histogram, res, edges, closed=:right)

# t = linspace(-5,5)
# t = linspace(0,1)
# y = 1/sqrt(2*pi*s2)*exp.(-t.^2/(2*s2))
# y = k*t.^(k-1)

#hx = fit(Histogram, x[1,:], edges, closed=:right)
# we need to normalize the shit by taking into account the width of the bins
# plot(edges, hx.weights/N/(t[2]-t[1]))
#plot(t, y)
plot(edges, hres.weights/N/(edges[2]-edges[1]))
