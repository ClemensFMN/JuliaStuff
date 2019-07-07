using Distributions
using StatsBase
using Plots
plotly()

# assume N Gaussian RVs 
# calculate sample mean and sample variance
# calculate the confidence interval for mu_hat
# and count in how many runs the real mean is within the confidence interval

mu = 0.5
s2 = 0.2

N = 3
RUNS = 100_000


p = Normal(mu, sqrt(s2))
pconf = 0.8
ptdist = TDist(N-1) # -> Maybe obtain tstar from inverse cdf function?
tstar = quantile(ptdist, (pconf+1) / 2)

ininterval = zeros(RUNS)

for ind=1:RUNS
    x = rand(p, N)

    mu_hat = mean(x)
    s2_hat = 1/(N-1) * sum((x .- mu_hat).^2)

    lwr = mu_hat - tstar * sqrt(s2_hat / N)
    upr = mu_hat + tstar * sqrt(s2_hat / N)

    # @show mu_hat, lwr, upr

    if(mu > lwr) & (mu < upr)
    	ininterval[ind] = 1
    end
end

println(sum(ininterval) / RUNS)
