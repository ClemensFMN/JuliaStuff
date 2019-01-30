using Distributions
using Plots
plotly()

N = 1_000_000
a = 2.0

p = Uniform()

u = rand(p, N)

x = sqrt.(a^2 * u)

histogram(x, 60)
