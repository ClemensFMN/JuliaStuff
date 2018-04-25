using DifferentialEquations
using Plots
plotly()

#f(du,u,p,t) = 1/0.3*( (1-u.^2).*du - u)

function sys!(du,u,p,t)
  du[1] = 1/0.3*((1-u[2].^2)*u[1] - u[2])
  du[2] = u[1]
end

u0=[0.0,1.0]
tspan = (0.0,20.0)

prob = ODEProblem(sys!,u0,tspan)
sol = solve(prob,Tsit5(),reltol=1e-8,abstol=1e-8)
A = convert(Array, sol)

plot(sol.t, A[2,:], linewidth=2,xaxis="time (t)",yaxis="u(t)")
