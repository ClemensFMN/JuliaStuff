using DynamicalSystems # load the library
using Plots


function model(u,p,t)
  v1 = 2*u[1] - 1.2.*u[1].*u[2]
  v2 =  -u[2] + 0.9.*u[1].*u[2]
  return SVector(v1, v2)
end

u0= [1.0, 0.5]

ppmodel = ContinuousDynamicalSystem(model, u0, p)
T = 20.0 # total time
Dt = 0.01 # sampling time
A = trajectory(ppmodel, T; Dt)

# time series plot
#plot(sol,linewidth=2,xaxis="time (t)",yaxis="R(t), F(t)")