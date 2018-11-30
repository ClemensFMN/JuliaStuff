using Distributions

p = 0.73
N = 1_000_000


prb = Geometric(p)


vals = rand(prb, N)

println("P(X>0): measured = ", length(findall(x -> x > 0, vals)) / N, "; analytical = ", 1-p)

println("P(X even): measured = ", length(findall(x -> x%2 == 0, vals)) / N, "; analytical = ", 1/(2-p))

