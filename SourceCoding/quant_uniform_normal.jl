include("quant_simple.jl")
using Distributions
using Plots
plotly()

# quantize a normal source with N(0,1)
# with M levels between -Xmax and Xmax
# as the source

M = 8

Xmax = 1.0
delta = 2*Xmax / M

dcsn = -Xmax:delta:Xmax
repr = -Xmax - delta/2 : delta : Xmax + delta/2

RUNS = 100_000

s2s_vec = 0.1:0.05:1.5
mse = zeros(length(s2s_vec))

# using the quantizer

for (ind, s2s) in enumerate(s2s_vec)

    p = Normal(0, s2s) 

    # the quantization error
    q = zeros(RUNS)

    for iter = 1:RUNS
        x = rand(p) # get a random input
        y = quant(dcsn, repr, x) # quantize it using decision boundaries & representation values
        q[iter] = (y - x)^2 # measure and store the squared error
    end

    mse[ind] = mean(q)
    println(10*log10( s2s / mean(q) )) # SNR using the measured quantisation noise
end

res = 10 * log10.(s2s_vec ./ mse)
plot(s2s_vec, res)

