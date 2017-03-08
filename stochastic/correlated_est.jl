# we have two RVs \theta = \theta_1, \theta_2 distributed as
# \theta \sim N(0, [1 rho; rho 1])
# i.e. the thetas are correlated
# we observe y = \theta + w, w \sim N(0, \sigma_w^2 eye(2))
# and want to estimate \theta

rho = 0.999
sigma2_w = 10


Lambda = [1 rho;rho 1]^(-1)
L = 1/sigma2_w * eye(2)

Sigma = (Lambda + L)^(-1)

# we obtain the MMSE estimate for theta by \hat theta = A y with

A = Sigma*L

println(A)
