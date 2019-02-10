using LinearAlgebra

# we have a simple linear regression problem y = kx+d

k = 1.2
d = 0.5

x = [0,1,2,3,4]
ytrue = k*x .+ d

# stack a vector with ones on the left for the bias term
xones = [x [1,1,1,1,1]]

# alternative formulation for y
yobs = xones*[k;d] + 0.01*randn(5,1)

# and estimate the params using pseudo inverse
theta_hat = pinv(xones)*yobs
