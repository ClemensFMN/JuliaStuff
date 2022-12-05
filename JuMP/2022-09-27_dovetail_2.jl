using JuMP
using HiGHS

# this is based on the Dovetail model...
A = [1 1; 3 1; 1 0; 0 1]

# selling Pi yields a gain of pi
p = [3, 2]

# we have only limited resources available
r = [9; 18; 7; 6]

model = Model(HiGHS.Optimizer)


@variable(model, m[1:2])

# sum of price x amount yields the total revenue which we want to maximize 
@objective(model, Max, sum(p .* m))

@constraint(model, A * m .<= r)
@constraint(model, m .>= 0)

println(model)

optimize!(model)
println(termination_status(model))

println(objective_value(model))
println("amounts = ", value.(m))

# calculating the slack
println("slacks = ", A*value.(m) - r)
