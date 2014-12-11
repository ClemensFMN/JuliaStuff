using Winston

include("fir_design.jl")


L = 50
passbands = [0 1.0;1.5 2.2]

h = fir_window_design(L, passbands, rect)

w1, h1 = freqz(h, [1])

p = FramedPlot()
setattr(p.frame1, draw_grid=true, tickdir=1)

add(p, Curve(w1[1:511], 20*log10(abs(h1[1:511])), color="blue"))


