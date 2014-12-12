using Winston

include("fir_design.jl")

# filtering signals with FIR filters

# part one - generate a fir filter using the window methd
#L = 50
#passbands = [0 1.0]
#h = fir_window_design(L, passbands, rect)

# part two - generate a fir filter with two zeros exp(+/- im pi / 4)
h = [1, -2*cos(pi/4), 1]


if(false) then

	n = [0:500]
	theta = pi/4 # part two: choosing pi/4 gives an exact zero :-)

	x = cos(n*theta)
	y = filt(h, [1], x)

	ind = [450:500]
	plot(n[ind], x[ind], "r", n[ind], y[ind], "b")

else

	w1, h1 = freqz(h, [1])

	p = FramedPlot()
	setattr(p.frame1, draw_grid=true, tickdir=1)

	add(p, Curve(w1[1:511], 20*log10(abs(h1[1:511])), color="blue"))

end
