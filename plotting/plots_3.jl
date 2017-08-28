using Plots
plotly()

# More special topics...

x = linspace(1,10)
y = exp.(x)
plot(x,y,yscale=:log10)

#x = randn(10000)
#histogram(x, bins=50)

