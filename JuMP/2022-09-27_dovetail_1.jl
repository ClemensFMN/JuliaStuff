using JuMP
using HiGHS
using DataFrames

model = Model(HiGHS.Optimizer)

@variable(model, x1)
@variable(model, x2)

@constraint(model, c1, x1 + x2 <= 9)
@constraint(model, c2, 3*x1 + x2 <= 18)
@constraint(model, c3, x1 <= 7)
@constraint(model, c4, x2 <= 6)
@constraint(model, c5, x1 >= 0)
@constraint(model, c6, x2 >= 0)

@objective(model, Max, 3*x1 + 2*x2)



println(model)

optimize!(model)
println(termination_status(model))

println(objective_value(model))
println("x1 = ", value(x1), " x2 = " ,value(x2))



constraints = all_constraints(model; include_variable_in_set_constraints = false)

for c in constraints

    # println(c)
    val = value(c)
    rhs = normalized_rhs(c)
    slack = normalized_rhs(c) - value(c)

    println("Constraint: ", c, " slack: ", slack)
    
end



# inspired by https://jump.dev/JuMP.jl/dev/tutorials/linear/lp_sensitivity/
#function constraint_report(c::ConstraintRef)
#    return (
#        name = name(c),
#        value = value(c),
#        rhs = normalized_rhs(c),
#        slack = normalized_rhs(c) - value(c),
#        shadow_price = shadow_price(c),
#        allowed_decrease = report[c][1],
#        allowed_increase = report[c][2],
#    )
#end

#report = lp_sensitivity_report(model)

#constraint_df = DataFrames.DataFrame(
#    constraint_report(ci) for (F, S) in list_of_constraint_types(model) for
#    ci in all_constraints(model, F, S) if F == AffExpr
#)
