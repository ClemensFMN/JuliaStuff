using Statistics

# we create a random x \sim N(0,1)
# and then a random y according to y = a*x + w
# with w \sim N(0,1)
# and calculate the correlation between x & y

N = 100000
a = 0.1

x = randn(N)
y = a*x + randn(N)


println("estimated variance of y = ", var(y))
println("analytical result = ", 1 + a^2)

# the Julia function calculates E(xy) / sqrt(E(x^2) E(y^2))
println("estimated correlation between x & y = ", cor(x,y))
println("analytical result = ", a / sqrt(1+a^2))

# this the unnormalized correlation which we define as E(xy)
unnorm_corr(x,y) = mean(x .* y)

println("estimated unnormalized corr between x & y = ", unnorm_corr(x,y))
println("analytical result = ", a)


