using JuMP


m = Model()

@defVar(m, 0 <= x <= 2, Int)
@defVar(m, 0 <= y <= 2, Int)

#@setObjective(m, Max, x + y )

status = solve(m)

println("Objective value: ", getObjectiveValue(m))
println("x = ", getValue(x))
println("y = ", getValue(y))

