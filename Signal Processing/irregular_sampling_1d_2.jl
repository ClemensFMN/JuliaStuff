# using FFTW
#using Plots
#plotly()

using LinearAlgebra

# Irregular Sampling based on Channel Estimation in Wireless OFDM Systems with irregular Pilot Distribution

# the trick to get it finally working was to consider a low-pass spreading function
# with finite support

N = 64
n = 1:N
K = 7 # support of the spreading function

strue = zeros(Complex{Float64},K)
strue[1] = 1
strue[2] = 1.5+0.4im
strue[3] = -0.4
strue[6] = -0.4
strue[7] = 1.5-0.4im

#plot(x)
# plot(abs.(fft(x)))


V = zeros(Complex{Float64},N,N)

for i=1:N
  for j = 1:N
     V[i,j] = exp(-1im*2*pi*(i-1)*(j-1)/N)
  end
end

# the spreading function is low-pass; it is non-zero at low & high indices
ind_low = 1:convert(Int, ceil(K/2)) # the first K/2+1 bins (that includes the DC part)
ind_high = N-convert(Int, floor(K/2))+1:N # the upper most K/2 bins which are the mirrored lower freqs
V = V[:,[ind_low; ind_high]] # selecting the relevant cols from V


# num and position of irregularly spaced samples
ind_sample = [1,2,3,4,30,60,62,64]
Np = length(ind_sample)


P = zeros(Int, Np, N)
# setting the pilot matrix to one at pilot positions
for i=1:Np
	P[i,ind_sample[i]] = 1
end

Vp = P*V
hp = Vp*strue

# directly inverting the normal equations
shat = inv(Vp'*Vp) * Vp' * hp

# condition number
# eigen(Vp'*Vp)


T = Vp' * Vp
hpre = Vp' * hp


function conjGrad(T, ypre)
	a = ypre
	b = ypre
	c = T*b
	alpha_prev = norm(a)^2
	K,_ = size(T)
	shat_prev = zeros(K)

	for i = 1:50
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

