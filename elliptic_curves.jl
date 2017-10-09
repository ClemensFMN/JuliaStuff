using Plots
plotly()


x = linspace(-2,5, 1000)
y1 = x.^3 - 3*x + 3

ind1 = find(x->x>=0, y1)

plot(x[ind1],sqrt.(y1[ind1]), lab="")
plot!(x[ind1],-sqrt.(y1[ind1]), lab="", grid=true)


