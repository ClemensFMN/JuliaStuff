using DifferentialEquations
using Plots
plotly()

function model(du,u,p,t)
  du[1] = 2*u[1] - 1.2.*u[1].*u[2]
  du[2] =  -u[2] + 0.9.*u[1].*u[2]
end

u0= [1.0 0.5]
# u0= [1/0.9 2/1.2]
tspan = (0.0,10.0)

prob = ODEProblem(model,u0,tspan)
sol = solve(prob, reltol=1e-8,abstol=1e-8) #,Tsit5(),reltol=1e-8,abstol=1e-8)

# time series plot
# plot(sol,linewidth=2,xaxis="time (t)",yaxis="R(t), F(t)")

# plot phase space
plot(sol, vars=(1,2))

# for uinit1 = 0.2:0.3:2.0
#   u0 = [1.0 uinit1]
#   print(u0)

#   prob = ODEProblem(model,u0,tspan)
#   sol = solve(prob, reltol=1e-8,abstol=1e-8)

#   # plot phase space
#   plot!(sol, vars=(1,2))

# end


# gui()


function model2(du,u,p,t)
  du[1] = 2*u[1] - 1.5.*u[1].*u[2]
  du[2] =  -u[2] + 0.4.*u[1].*u[2]
end

prob = ODEProblem(model2,u0,tspan)
sol2 = solve(prob, reltol=1e-8,abstol=1e-8) #,Tsit5(),reltol=1e-8,abstol=1e-8)

# time series plot
# plot!(sol2,linewidth=2,xaxis="time (t)",yaxis="R(t), F(t)")


# plot phase space
plot!(sol2, vars=(1,2))
