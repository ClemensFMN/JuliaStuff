using Images
using FFTW
using ImageView

# loading an image, performing a 2D-FFT, zeroing coeffs outside the middle
# and IFFTing back the image
# -> there is a lot of redundant information in the picture...

img  = load("IMG_20190102_084337.jpg")

gs = convert(Array{Float64},Gray.(img))

gstilde = fftshift(fft(gs))

a,b = size(gstilde)

La = 1700
Lb = 1400

gstilde[1:La,:] = zeros(La,b)
gstilde[a:-1:a-(La-1),:] = zeros(La,b)
gstilde[:,1:Lb] = zeros(a,Lb)
gstilde[:,b:-1:b-(Lb-1)] = zeros(a,Lb)

gsrec = ifft(ifftshift(gstilde))

imshow(abs.(gsrec))
