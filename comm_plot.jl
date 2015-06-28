using Winston


r1 = resL1 = readdlm("L1.csv", '\t')
r2 = resL2 = readdlm("L2.csv", '\t')
r4 = resL4 = readdlm("L4.csv", '\t')

snr = r1[:,1]

p = FramedPlot()

add(p, Curve(snr,  r1[:,2], color="red"))
add(p, Curve(snr,  r2[:,2], color="green"))
add(p, Curve(snr,  r4[:,2], color="blue"))

setattr(p.y, "log", true)

# add(p, Curve(snr,  snr))




display(p)

savefig("ber.png")

