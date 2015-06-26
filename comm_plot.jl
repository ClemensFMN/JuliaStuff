using Winston


r1 = resL1 = readdlm("L1.csv", '\t')
r2 = resL2 = readdlm("L1.csv", '\t')
r4 = resL4 = readdlm("L1.csv", '\t')

snr = r1[:,1]

p = FramedPlot()

#add(p, Curve(snr,  r1[:,2]))
#add(p, Curve(snr,  r2[:,2]))
#add(p, Curve(snr,  r4[:,2]))

add(p, Curve(snr,  snr))




display(p)

savefig("ber.png")

