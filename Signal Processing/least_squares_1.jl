# simple least squares

# we want to solve the following problem
#
# shat = \arg \min |y - H s|
#
# which leads to the normal equations H^H y = H^H H shat and shat = (H^H H)^{-1} H^H y

H = randn(5,2) #+ 1im*randn(5,2)
strue = [1,2]

y = H*strue

# direct solution
shat = inv(H'*H)*H'*y

# aside: fun with reduced observations
P = [1 0 0 0 0;
     0 0 1 0 0]

yred = P*y
Hred = P*H
shatred = inv(Hred'*Hred)*Hred'*yred

# end of aside

# solve the normal equations H^H y = H^H H shat for shat by means of the conjugate gradient algorithm
# We define
# T shat = ypre
# with
T = H' * H
ypre = H' * y

# this is based on Irregular Sampling based on Channel Estimation in Wireless OFDM Systems with irregular Pilot Distribution
function conjGrad(T, ypre)

	a = ypre
	b = ypre
	c = T*b
	alpha_prev = norm(a)^2
	shat_prev = zeros(2)

	for i = 1:10
		beta = alpha_prev / (b' * c)
		shat_cur = shat_prev + beta*b
		a = a - beta * c
		alpha_cur = norm(a)^2
		gamma = alpha_cur / alpha_prev
		b = a + gamma * b
		c = T*b
		alpha_prev = alpha_cur
		shat_prev = shat_cur
		@show shat_cur

	end
end

conjGrad(T, ypre)
# conjGrad(H'*H, H'*y)
# conjGrad(Hred'*Hred, Hred'*yred)
