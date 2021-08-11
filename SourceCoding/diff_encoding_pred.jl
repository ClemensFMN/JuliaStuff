using DSP
using StatsBase
using Plots
plotly()


# manual calculation of autocorrleation of sequence x up to maxLag
function auto_corr(x, maxLag)
	N = length(x)
	R = zeros(maxLag)


	for lag = 0:maxLag-1
		#@show lag
		temp = 0
		for k = 1:N-lag
			#@show k
			temp = temp + x[k]*x[k+lag]
		end
		R[lag+1] = temp / (N-lag)
	end
	R
end



a = [1.]
b = [1.0, -0.6, 0.3]


N = 1000_000

# we take a random input signal
w = randn(N)

# and filter it with a FIR filter (FIR, therefore a = [1])
x = filt(b, a, w)

# we estimate the autocorrelation of the filtered signal
# Rx = auto_corr(x, 5)
Rx = autocov(x, [0,1,2,3])
@show Rx

# and compare it with the analytical computation
@show b[1]^2 + b[2]^2 + b[3]^2
@show b[1]*b[2]+  b[2]*b[3]
@show b[1]*b[3]

# Wiener Hop Equation

# define terms 
Rmatrix = [Ry[1] Ry[2] Ry[3] ; Ry[2] Ry[1] Ry[2]; Ry[3] Ry[2] Ry[1]]
pvec = [Ry[2], Ry[3], Ry[4]]

# calc coefficients for prediction filter
pred_b = inv(Rmatrix) * pvec

# apply the filter to the observed sequence - not sure if this correct!?
ypred = filt(pred_b, a, x)


plot(y[1:100])
plot!(ypred[1:100])

