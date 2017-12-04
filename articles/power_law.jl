using Plots
plotly()

using StatsBase

N = 1000000

alpha = 1.5
xmin = 2

r = rand(N)
x = xmin*(1-r).^(-1/(alpha-1))

# estimate alpha from the observations
# true xmin
alpha_hat = 1 + N / sum(log.(x./xmin))
println(alpha_hat)

# "estimate" xmin by taking the minimum value of the observed sequence
xmin_hat = minimum(x)
alpha_hat_2 = 1 + N / sum(log.(x./xmin_hat))
println(alpha_hat_2)


#edges = 1:1000
#h = fit(Histogram, x, edges)
#plot(edges, log10(h.weights), xscale=:log10)

