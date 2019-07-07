using Distributions
using Plots
plotly()


s1 = TDist(3)
s2 = TDist(10)

n = Normal()

x = -5:0.05:5

plot(x, pdf(s1, x), label="Student, DoF = 3")
plot!(x, pdf(s2, x), label="Student, DoF = 10")
plot!(x, pdf(n, x), label="Normal(0,1)")



