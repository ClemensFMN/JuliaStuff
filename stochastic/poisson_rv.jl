using Distributions

a = 0.4
N = 100_000

prb = Poisson(a)


vals = rand(prb, N)

println("P(X>0): measured = ", length(findall(x -> x > 0, vals)) / N, "; analytical = ", 1-exp(-a))

println("P(X even): measured = ", length(findall(x -> x%2 == 0, vals)) / N, "; analytical = ", 1/2*(1+exp(-2*a)))

