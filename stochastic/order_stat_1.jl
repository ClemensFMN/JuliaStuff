using Distributions
using Plots
plotly()
using StatsBase


# we consider a normal distribution
s2 = 1.5
#p = Normal(0,sqrt(s2))
p = Uniform()

k = 5

N = 500000
edges = linspace(-2,2, 50)

x = rand(p, k, N)

# and take the maximum of k samples; i.e. the k-th order statistics
res = maximum(x, 1)
hres = fit(Histogram, res[1,:], edges)

t = linspace(-5,5)
y = 1/sqrt(2*pi*s2)*exp.(-t.^2/(2*s2))

hx = fit(Histogram, x[1,:], edges)
# we need to normalize the shit by taking into account the width of the bins
plot(edges, hx.weights/N/(t[2]-t[1]))
#plot!(t, y)
plot!(edges, hres.weights/N/(t[2]-t[1]))
