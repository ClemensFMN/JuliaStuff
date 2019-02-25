using FFTW
using DSP


# OFDM Principle

# FD signal
s=[1., 3., -2.]

x=ifft(s)

xtilde=zeros(Complex{Float64},5)
xtilde[3:5]=x
# add a cyclic prefix of length 2; i.e. the last two elements are appended at the beginning
xtilde[1]=x[2]
xtilde[2]=x[3]


# channel vector
h=[1., -0.2]
# zero-padded channel vector the same length as the FD signal
hfft = [h ; 0]

# TD: convolution
ytilde=conv(xtilde,complex(h))

# removing the CP
y = ytilde[3:5]

# channel equalization
xhat = fft(y) ./ fft(hfft)








