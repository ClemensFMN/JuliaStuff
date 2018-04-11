# using Winston
using Plots
plotly()

x = linspace(1, 20, 20)

y = pi.^(x/2) ./ (2.^x .* gamma(x/2+1))


plot(x, y, linecolor=:red, yscale=:log10)
