using Plots
plotly()


# using layout to split a plot into several subplots
#scatter(x,[y1,y2], layout=(2,1))



p1 = plot(x,y1) # Make a line plot
p2 = scatter(x,y2) # Make a scatter plot
plot(p1,p2,layout=(2,1),legend=false)


