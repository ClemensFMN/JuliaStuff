using DifferentialEquations
using Plots
plotly()

f(u,p,t) = u*sin(t.^2)
u0=1.0
tspan = (0.0,8.0)

prob = ODEProblem(f,u0,tspan)
sol = solve(prob,Tsit5(),reltol=1e-8,abstol=1e-8)

plot(sol,linewidth=2,xaxis="time (t)",yaxis="u(t)")
