using DSP
using Plots
plotly()


bpass = remez(80, [0, 0.1, 0.15, 0.4, 0.45, 0.5], [db2amp(-10), 1, db2amp(-20)])
b = DSP.Filters.PolynomialRatio(bpass, [1.0])


f = range(0, stop=0.499, length=1000) #linspace(0, 0.5, 1000)


plot(f, 20*log10.(abs.(freqz(b,f,1.0))))
# why not this?
# plot(f, amp2db.(abs.(freqz(b, f, 1.0))))

