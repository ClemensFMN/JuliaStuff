using Plots

x = 0:0.05:2

y1 = 10 .- 5 .* x
y2 = 5 .- 1/2 .* x

# plot the min of y1 & y2 in order to get the constraint
plot(x,min.(y1, y2), label="Constraint", linewidth=2, linecolor=:red)

# TODO: How can we plot the objective function?
y = 0:0.05:5
contour!(x,y,(x,y) -> 7*x+y)
