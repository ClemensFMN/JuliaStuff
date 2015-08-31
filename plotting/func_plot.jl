using Winston

x = linspace(0, 5, 100)

y = gamma(x)


plot(x, y, "g-")
grid(true)
savefig("gamma_plot.png")