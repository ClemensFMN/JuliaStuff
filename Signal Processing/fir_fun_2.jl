using Winston

include("fir_design.jl")


L = 50
passbands = [Passband(1, 0.0, 0.6), Passband(2, 1.3, 1.8)]

h = fir_window_design(L, passbands, rect)

w1, h1 = freqz(h, [1])

p = FramedPlot()
setattr(p.frame1, draw_grid=true, tickdir=1)

add(p, Curve(w1[1:511], 20*log10(abs(h1[1:511])), color="blue"))

