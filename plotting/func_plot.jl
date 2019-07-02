using Plots
plotly()

function vol(N)
  return pi.^(N/2) ./ (gamma(N/2+1))
end

x = range(0, stop=4, length=100)

# y = vol(x)

# y1 = x.^2
# y2 = sqrt.(x)

# plot(x, y1)#, linecolor=:red)#, yscale=:log10)
#plot!(x,y2, linecolor=:blue)



x=0:0.01:1

# y1 = x.^0.3 .* (1 .- x ).^0.8
# y1 = y1 ./ sum(y1)

# y2 = x.^0.8 .* (1 .- x ).^0.3
# y2 = y2 ./ sum(y2)

# y3 = x.^0.5 .* (1 .- x ).^0.5
# y3 = y3 ./ sum(y3)

y1 = x.^1.3 .* (1 .- x ).^2.5
y1 = y1 ./ sum(y1)

y2 = x.^0.3 .* (1 .- x ).^1.8
y2 = y2 ./ sum(y2)

#y3 = x.^0 .* (1 .- x ).^0
#y3 = y3 ./ sum(y3)



plot(x,y1)
plot!(x,y2)
#plot!(x,y3)
