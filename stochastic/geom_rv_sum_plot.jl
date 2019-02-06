using Plots
plotly()


alpha = 0.2
beta = 0.7

zvec = 0:20
res_analytic_ce = zeros(length(zvec))


for (ind, z) in enumerate(zvec)

  res_analytic_ce[ind] = alpha*beta/(alpha-beta)*((1-beta)^(z+1) - (1-alpha)^(z+1))

end

plot(zvec, res_analytic_ce)

