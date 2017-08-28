using Plots
plotly()

#based on https://juliaplots.github.io/examples/plotlyjs/

plot(0:10:100,rand(11,4),lab="lines",w=3,palette=:grays,fill=0,α=0.6)
