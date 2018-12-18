using Distributions

alpha = 0.2
beta = 0.7
N = 1_000_000


palpha = Geometric(alpha)
pbeta = Geometric(beta)


Xvals = rand(palpha, N)
Yvals = rand(pbeta, N)


Z = Xvals + Yvals

z = 10

println("P(Z): measured = ", length(findall(x -> x == z, Z)) / N)

k = 0:z

res_analytic = sum(alpha.*(1-alpha).^k.*beta.*(1-beta).^(z.-k))
res_analytic_ce = alpha*beta/(alpha-beta)*((1-beta)^(z+1) - (1-alpha)^(z+1))

println(res_analytic)
println(res_analytic_ce)

# println("analytical = ", alpha*beta / (1-alpha)*((1-beta)^(z+1) - (1-alpha)^(z+1)))
