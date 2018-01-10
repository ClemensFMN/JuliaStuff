using Distributions
using Plots
plotly()
using StatsBase

# empirical order statistics for uniform and normal RVs 

# we consider a normal distribution
#s2 = 1.5
#p = Normal(0,sqrt(s2))
# we consider a uniform distribution
p = Uniform()

# number of RVs
kmax = 10
# order of RV to consider
k = 1

# num of trials
N = 500000
edges = linspace(-2,2,50)

x = rand(p, kmax, N)

# sort column-wise
x = sort(x,1)

# and take the k-th order statistics
res = x[k,:]
# and obtain a histogram
hres = fit(Histogram, res, edges, closed=:right)

# comparing the histogram with the analytical pdf (uniform only)
t = linspace(0,1)
# maximum
#y = kmax*t.^(kmax-1)
# minimum
y = kmax*(1-t).^(kmax-1)
plot(t, y)
# we need to normalize the shit by taking into account the width of the bins
plot!(edges, hres.weights/N/(edges[2]-edges[1]))
