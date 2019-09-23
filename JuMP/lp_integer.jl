using JuMP
using GLPK

model = Model(with_optimizer(GLPK.Optimizer))

@variable(model, 0 <= x <= 5, Int)
@variable(model, 0 <= y <= 5, Int)


@objective(model, Max, 5x + 3y)
@constraint(model, con, x <= y)

println(model)

optimize!(model)
println(termination_status(model))

println(objective_value(model))
println("x = ", value(x), " y = " ,value(y))
