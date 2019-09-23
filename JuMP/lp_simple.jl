using JuMP
using GLPK

model = Model(with_optimizer(GLPK.Optimizer))

@variable(model, 0 <= x <= 2)
@variable(model, 0 <= y <= 30)


@objective(model, Max, 5x + 3 * y)
@constraint(model, con, 1x + 5y <= 3)

println(model)

optimize!(model)
println(termination_status(model))

println(objective_value(model))
println("x = ", value(x), " y = " ,value(y))
