using Plots
plotly()

using SpecialFunctions

EbNodB = collect(-2:1:6)

# get No from the EbNo vector
No = 10 .^ (-EbNodB / 10)
# and calculate a bound for the bit error rate...
Pb57 = 1/2 * erfc.(sqrt.(5*1 ./ No))
#Pb1317 = 1/4 * erfc.(sqrt.(6*1 ./ No))

# data taken from /home/clnovak/src/cpp/IT++Stuff/ConvCodes/
# ber = [0.2289, 0.157535, 0.0902512, 0.0414637, 0.0139723, 0.00339688, 0.000585156, 7.14844e-05, 4.6875e-06]

# data obtained via cc_awgn_simu with a (05,07) code
ber57 = [0.226973; 0.155713; 0.0894336; 0.0407922; 0.0136664; 0.00337969; 0.00055; 8.98437e-5; 4.6875e-6]
ber1317 = [0.261096; 0.180694; 0.101227; 0.0410773; 0.0117109; 0.00223516; 0.000346875; 5.07813e-5; 2.34375e-6]
ber6474 = [0.25766; 0.180156; 0.0995008; 0.0413555; 0.0114195; 0.00244063; 0.000298438; 2.8125e-5; 3.90625e-6]


plot(EbNodB, ber57, yscale=:log10, label="(5,7) Code")
#plot!(EbNodB, ber1317, yscale=:log10, label="(13,17) Code")
plot!(EbNodB, ber6474, yscale=:log10, label="(64,74) Code")

#plot!(EbNodB, Pb57, yscale=:log10, label="Bound for (5,7) Code")
#plot!(EbNodB, Pb1317, yscale=:log10, label="Bound for (13,17) Code")

