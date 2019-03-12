using FFTW
using Plots
plotly()

# irregular sampling by means of FFT

N = 64

n = 1:N

# a low-pass signal
x = sin.((n.-1)/0.8/(2*pi))

#plot(x)
# plot(abs.(fft(x)))


F = zeros(Complex{Float64},N,N)

for i=1:N
  for j = 1:N
     F[i,j] = exp(-1im*2*pi*(i-1)*(j-1)/N)
  end
end

# num and position of irregularly spaced samples
Ncoeffs = 4
ind_sample = [1,21,51,61]
#Ncoeffs = 9
#ind_sample = [1,5,8,10,12,14,16,35,60]

# selecting the corresponding rows from F
G = F[1:Ncoeffs, ind_sample]

# the actual samples
xs = x[ind_sample]
# and their "FFT"
xstilde = G*xs

# symmetrizing the FFT
xstildesym = zeros(Complex{Float64},N)
xstildesym[1] = xstilde[1]
xstildesym[3] = xstilde[3]
# xstildesym[2:Ncoeffs] = xstilde[2:Ncoeffs]
xstildesym[63] = conj(xstilde[3])
# xstildesym[N - Ncoeffs+2:N] = conj(xstilde[Ncoeffs:-1:2])

# and going back to TD... the result does not really look like the original - maybe numerical issues due to irregular sampling??
xrec = real(ifft(xstildesym))
plot(x)
plot!(N/Ncoeffs*xrec)

plot!(ind_sample, xs)


