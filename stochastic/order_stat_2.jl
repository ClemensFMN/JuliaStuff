using Distributions
using Plots
plotly()

N = 5

d = Normal(0,2)

x = linspace(-10,10,100)

pdf_x = pdf.(d,x)
pdf_max = N * cdf.(d,x).^(N-1) .* pdf.(d,x)

plot(x,pdf_x)
plot!(x,pdf_max)
