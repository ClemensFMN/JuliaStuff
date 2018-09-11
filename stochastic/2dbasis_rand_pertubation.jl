using Statistics


x = [2;3]
phi = pi/2


N = 10000

x1 = x[1] .+ randn(N)
x2 = x[2] .+ randn(N)

a1 = x1 - x2 / tan(phi)
a2 = x2 / sin(phi)

println(var(a1))
println(var(a2))


