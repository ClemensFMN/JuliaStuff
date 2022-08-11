using JuMP
using HiGHS

# we can produce two products, P1 & P2
# both are created from 2 resources R1, R2
# producing one quantity of P1 requires A[1,1] items of R1 and A[2,1] items of R2
# producing one quantity of P2 requires A[1,2] items of R1 and A[2,2] items of R2
A = [5 1; 1/2 1]

# selling Pi yields a gain of pi
p = [1,1]

# we have only limited resources available
r = [10; 5]

model = Model(HiGHS.Optimizer)

# define the vector of sold items; to consider the (sometimes simpler) LP, we can remove the Int constraint on the variable...
@variable(model, m[1:2], Int)

# sum of price x amount yields the total revenue which we want to maximize 
@objective(model, Max, sum(p .* m))

@constraint(model, A * m .<= r)
@constraint(model, m .>= 0)

println(model)

optimize!(model)
println(termination_status(model))

println(objective_value(model))
println("amounts = ", value.(m))
