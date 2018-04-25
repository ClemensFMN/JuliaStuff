using DifferentialEquations
using Plots
plotly()

# start with y' - ay = 0 which has solution y(t) = C e^(at) Now let's consider
# the system y' - sin(t^2)y = 0 This can be interpreted as ODE with time-varying
# coefficient a: If the coefficient > 0, then the solution increases, otherwise
# it decays

f(u,p,t) = u.*sin.(t.^2)

tspan = (0.0,4.0)
u0 = 1.0

prob = ODEProblem(f,u0,tspan)
sol = solve(prob,Tsit5(),reltol=1e-8,abstol=1e-8)
p = plot(sol,linewidth=2,xaxis="time (t)", label="y(t)")

# we can get more insight by plotting the time-varying coefficient
aval = sin.(sol.t.^2)
plot!(p, sol.t, aval, label="sin(t^2)")

plot(p)
