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
kmax = 20


# num of trials
N = 500000
# edges = linspace(-2,2,50)
edges = linspace(-0.2,1.2,50)


x = rand(p, kmax, N)

# sort column-wise
x = sort(x,1)

hres = zeros(kmax, length(edges)-1)

for k = 1:kmax
	println(k)
	# and take the k-th order statistics
	res = x[k,:]
	# and obtain a histogram
	temp = fit(Histogram, res, edges, closed=:right).weights
	#println(temp)
	hres[k,:] = temp
end

plot(edges, hres'/N/(edges[2]-edges[1]))


