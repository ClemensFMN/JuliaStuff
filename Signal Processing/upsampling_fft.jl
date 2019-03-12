using FFTW
using Plots
plotly()

# FFT-based interpolation

N = 64

n = 1:N

# a low-pass signal
x = sin.((n.-1)/0.8/(2*pi))

# subsampling factor
L = 4
ind_sample = collect(1:L:N)


xsampled = zeros(length(ind_sample))
xsampled = x[ind_sample] # downsample the original signal at fewer positions

#plot(x)
#plot!(ind_sample, xsampled)

# take the FFT of the downsampled signal; fftshift makes this a real spectrum with DC in the middle
xsampledtilde = fftshift(fft(xsampled))

# plot(abs.(xsampledtilde))

# prepare to upsample; i.e. add zeros to the left and right of the downsampled spectrum
xtilde = zeros(Complex{Float64},N)
start = 1+convert(Int, N/2 - N/L/2)
stop = convert(Int, N/2 + N/L/2)

xtilde[start:stop] = xsampledtilde # add the spectrum of the downsampled signal in the middle - the start & stop indices are tricky!

# plot(abs.(xtilde))
# plot(abs.(ifftshift(xtilde)))

# ifftshift reverses the effect of fftshift & go back to time domain
xrec = ifft(ifftshift(xtilde))

plot(x)
plot!(real(L*xrec)) # scaling up (due to downsampling) yields the reconstructed signal

