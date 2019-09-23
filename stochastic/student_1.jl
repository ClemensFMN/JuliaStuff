using Distributions
using StatsBase
using Plots
plotly()

# assume N Gaussian RVs 
# calculate sample mean and sample variance
# calculate the t value & plot its distributions
# which should be Student-distributed with N-1 DoFs

mu = 0.5
s2 = 0.2

N = 3
RUNS = 100_000


p = Normal(mu, sqrt(s2))


t = zeros(RUNS)

for ind=1:RUNS
    x = rand(p, N)

    mu_hat = mean(x)
    s2_hat = 1/(N-1) * sum((x .- mu_hat).^2)

    t[ind] = (mu_hat - mu) / (sqrt(s2_hat) / sqrt(N))

end

edges = -6:0.1:6

hx = fit(Histogram, t, edges)

plot(edges[1:end-1], hx.weights./sum(hx.weights), seriestypes=:scatter, label="histogram")

pt = TDist(N-1)

plot!(edges, pdf(pt, edges)/10, label="Student, DoF = N-1")

pn = Normal(0,1)
plot!(edges, pdf(pn, edges)/10, label="Normal(0,1)")




