# using FFTW
#using Plots
#plotly()

using LinearAlgebra

# Irregular Sampling based on Channel Estimation in Wireless OFDM Systems with irregular Pilot Distribution

N = 10
n = 1:N

strue = zeros(Complex{Float64},N)
strue[1] = 1+1im
strue[2] = 1.5+0.4im
strue[3] = -0.4

#plot(x)
# plot(abs.(fft(x)))


V = zeros(Complex{Float64},N,N)

for i=1:N
  for j = 1:N
     V[i,j] = exp(-1im*2*pi*(i-1)*(j-1)/N)
  end
end

# num and position of irregularly spaced samples
ind_sample = [1,5,10]
Np = length(ind_sample)

P = zeros(Int, Np, N)

for i=1:Np
	P[i,ind_sample[i]] = 1
end


Vp = P*V
# htrue = V * strue
# hp = P*htrue

hp = Vp*strue

# does not work
shat = inv(Vp'*Vp) * Vp' * hp

# the condition number is more or less infinite -> the matrix does not seem to be invertible...
# eigen(Vp'*Vp)




T = Vp' * Vp
hpre = Vp' * hp


function conjGrad(T, ypre)

	a = ypre
	b = ypre
	c = T*b
	alpha_prev = norm(a)^2
	shat_prev = zeros(10)

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
		println(shat_cur)

	end
end

# conjGrad((P*V)'*(P*V), (P*V)'*hp)
conjGrad(T, hpre)

