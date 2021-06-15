include("quant_simple.jl")
using Distributions

# quantize a uniform source in the interval [-Xmax, Xmax]
# with M levels
# as the source
# we prepare decision boundaries / representation values for "one" outside the interval, but it is not necessary...

Xmax = 1.0
M = 8

delta = 2*Xmax / M
# the first & last boundary will not be used as x will never be outside the [-Xmax, Xmax interval]
dcsn = -Xmax:delta:Xmax
repr = -Xmax - delta/2 : delta : Xmax + delta/2

RUNS = 100_000

# using the quantizer with a different input
# different Xmax
# Xmax = 0.5
# different distribution
# p = Uniform(-Xmax, Xmax)
p = Normal(0, .1) 


# the quantization error
q = zeros(RUNS)

for iter = 1:RUNS
    x = rand(p) # get a random input
    y = quant(dcsn, repr, x) # quantize it using decision boundaries & representation values
    q[iter] = (y - x)^2 # measure and store the squared error
end

# the signal power
s2s = Xmax^2 / 3

@show 10*log10( s2s / mean(q) ) # SNR using the measured quantisation noise

n = log2(M) # number of bits used
@show 20*n*log10(2) # analytical result