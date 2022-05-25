using DifferentialEquations
using Plots
plotly()

TMax = 20.0

# start with y' - ay = sin(t)
#a = 1.
#f(u,p,t) = -a*u + 1#sin.(t)
#f(u,p,t) = -a*u + sin.(t)


#tspan = (0.0,TMax)
#u0 = 2.0

#prob = ODEProblem(f,u0,tspan)
#sol = solve(prob,Tsit5(),reltol=1e-8,abstol=1e-8)
#p = plot(sol,linewidth=2,xaxis="time (t)", label="y(t), a=-1, \omega=1")

a = 1/2.0
w = 3.0
f(u,p,t) = -a*u + sin.(w*t) # real(exp.(w*t*1im))

tspan = (0.0,TMax)
u0 = 1.0

prob = ODEProblem(f,u0,tspan)
sol = solve(prob,Tsit5(),reltol=1e-8,abstol=1e-8)
p = plot(sol,linewidth=2,xaxis="time (t)", label="y(t), a=-1/2, \omega=3")

a = -a
ySteadyState = imag((-a - w*1im)/(a^2 + w^2)*exp.(w*sol.t*1im))
plot!(p, sol.t, ySteadyState, label="steady-state solution")

#aval = exp.(a*sol.t)*(u0+1/a) - 1/a
# aval = ((a^2+1)*exp(a*sol.t)*u0-a*sin(sol.t)-cos(sol.t)+exp(a*sol.t))/(a^2+1)
#aval = (-a*sin(sol.t)-cos(sol.t))/(a^2+1)
#plot!(p, sol.t, aval, label="analytical result")

#plot(p, ylims=(-1.05, 1.05))
