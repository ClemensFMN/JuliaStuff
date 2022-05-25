using JuMP
import GLPK

profit = [3,5,7]
weight = [2,3,5]
capacity = 6

N = length(profit)

model = Model(GLPK.Optimizer)
# @variable(model, x[1:N], Bin)
@variable(model, x[1:N])
# Objective: maximize profit
@objective(model, Max, profit' * x)
# Constraint: can carry all
@constraint(model, weight' * x <= capacity)
@constraint(model, 0 .<= x .<= 1)
# @constraint(model, 0 .<= x)

# Solve problem using MIP solver
optimize!(model)

println("Objective is: ", objective_value(model))
println("Weight is: ", sum(weight .* value.(x)))
println("Solution is:")
for i in 1:N
    println("x[$i] = ", value(x[i]))
end
