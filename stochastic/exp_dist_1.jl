using Distributions

N = 100_000

l1 = 1.0
l2 = 2.0


p1 = Exponential(1/l1)
p2 = Exponential(1/l2)

x1 = rand(p1,N)
x2 = rand(p2,N)


println(count( x1 .< x2) / N)
println(l1 / (l1 + l2))


println(count( x1 .> x2) / N)
println(l2 / (l1 + l2))


# this should be exponential with l1 + l2
x = min.(x1, x2)

for a in 0:0.1:1.0
	println(count(x .< a) / N, "...", 1 - exp(-(l1+l2)*a)) # minimum check using CDF...
end
