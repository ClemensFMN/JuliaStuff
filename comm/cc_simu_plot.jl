using Plots
plotly()


EbNodB = collect(-2:1:6)

# data taken from /home/clnovak/src/cpp/IT++Stuff/ConvCodes/
ber = [0.2289, 0.157535, 0.0902512, 0.0414637, 0.0139723, 0.00339688, 0.000585156, 7.14844e-05, 4.6875e-06]


plot(EbNodB, ber, yscale=:log10)

