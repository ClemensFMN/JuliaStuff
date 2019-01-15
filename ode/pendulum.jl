# based on https://nbviewer.jupyter.org/github/JuliaDiffEq/DiffEqTutorials.jl/blob/master/PhysicalModels/ClassicalPhysics.ipynb

# Simple Pendulum Problem
using OrdinaryDiffEq, Plots
plotly()

#Constants
const g = 9.81
L = 1.0

#Initial Conditions
# u0 = [0.1,0] # small displacement, no initial velocity
u0 = [1.4,0] # large displacement, no initial velocity
tspan = (0.0,4.0)

#Define the linearized ODE
function linearized_pendulum(du,u,p,t)
    theta  = u[1]
    dtheta = u[2]
    du[1] = dtheta
    du[2] = -(g/L)*theta
end


#Define the nonlinear ODE
function nonlinear_pendulum(du,u,p,t)
    theta  = u[1]
    dtheta = u[2]
    du[1] = dtheta
    du[2] = -(g/L)*sin(theta)
end



# Pass to solver
prob_lin = ODEProblem(linearized_pendulum, u0, tspan)
sol_lin = solve(prob_lin,Tsit5())

# Pass to solver
prob_nonlin = ODEProblem(nonlinear_pendulum, u0, tspan)
sol_nonlin = solve(prob_nonlin,Tsit5())


# Plot
plot(sol_lin,linewidth=2,title ="Simple Pendulum Problem", xaxis = "Time", yaxis = "Height", label = ["Theta","dTheta"])
plot!(sol_nonlin,linewidth=2,title ="Simple Pendulum Problem", xaxis = "Time", yaxis = "Height", label = ["Theta","dTheta"])

# "result" small displacement has a smaller period than large one...
# can we somehow measure the period?
