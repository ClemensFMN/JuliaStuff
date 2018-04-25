using DifferentialEquations
using Plots
plotly()

# let's consider the autonoumus system y' + u cos(u) = 0
# depending on the inital value u0, the ODE provides different solutions

f(u,p,t) = -u.*cos.(u)

tspan = (0.0,4.0)

u0vec = [-4., -2., -1., 1., 2., 4.]

# we can get more insight how u0 affects the solution by plotting the phase space
#u = linspace(-5.0, 5.0)
#uval = f(u, 0, 0)
#p = plot(u, uval)

p = plot()

for u0 in u0vec
  prob = ODEProblem(f,u0,tspan)
  sol = solve(prob,Tsit5(),reltol=1e-8,abstol=1e-8)
  plot!(p,sol,linewidth=2,xaxis="time (t)",yaxis="u(t)", label="u0=$u0")
end

plot(p, ylims=(-5,5))
