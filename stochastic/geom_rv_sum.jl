using Distributions

alpha = 0.2
beta = 0.2
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

# special case when alpha = beta
res_analytic_equal = z*alpha^2*(1-alpha)^z


println(res_analytic)
println(res_analytic_ce)
println(res_analytic_equal)
