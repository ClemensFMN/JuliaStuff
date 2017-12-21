using Distributions
using Plots
plotly()

N1 = 4
N2 = 10

d = Normal(0,2)

x = linspace(-10,10,100)

pdf_x = pdf.(d,x)
pdf_max_1 = N1 * cdf.(d,x).^(N1-1) .* pdf.(d,x)
pdf_max_2 = N2 * cdf.(d,x).^(N2-1) .* pdf.(d,x)

plot(x,pdf_x)
plot!(x,pdf_max_1)
plot!(x,pdf_max_2)
