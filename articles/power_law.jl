using Plots
plotly()

using StatsBase

N = 100000

alpha = 1.5
xmin = 2

r = rand(N)
x = xmin*(1-r).^(-1/(alpha-1))

# histogram(x, bins=50)

edges = 1:1000

h = fit(Histogram, x, edges)

plot(edges, log10(h.weights), xscale=:log10)
