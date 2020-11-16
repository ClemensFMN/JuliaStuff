using Plots
plotly()



include("eratosthenes.jl")

ps = sieve(100_000)

gps = diff(ps)

histogram(gps, legend=false)

