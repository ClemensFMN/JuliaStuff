# using Winston
using Plots
plotly()

function vol(N)
  return pi.^(N/2) ./ (gamma(N/2+1))
end

x = range(0, stop=4, length=100)

# y = vol(x)

y1 = x.^2
y2 = sqrt.(x)

plot(x, y1)#, linecolor=:red)#, yscale=:log10)
#plot!(x,y2, linecolor=:blue)
