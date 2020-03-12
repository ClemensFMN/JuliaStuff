using DifferentialEquations
using Plots
plotly()

alpha = 1.0
# exponential growth
#f(u,p,t) = alpha*u

# expoential growth with slowing growth when enough people are infected
umax = 2.0
f(u,p,t) = alpha*(1-u/umax)*u

u0 = 0.1
tspan = (0.0,10.0)
prob = ODEProblem(f,u0,tspan)
sol = solve(prob, Tsit5(), reltol=1e-8, abstol=1e-8)


plot(sol, linewidth=3, xaxis="Time (t)", label="N(t)") # legend=false
plot!(sol.t, f.(sol.u,1,1), label="dN(t)/dt", linewidth=3)
#plot!(sol.t, t->0.5*exp(alpha*t),lw=3,ls=:dash,label="True Solution!")


