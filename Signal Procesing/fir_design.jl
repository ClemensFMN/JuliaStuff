using Winston
include("dsp_stuff.jl")


function fir_window_design(L, passbands, win_fct)

	m = [0:L-1] - (L-1)/2

	(npbs,_) = size(passbands)

	h = zeros(L)

	for i in 1:npbs
		pb = passbands[i,:]
		temp = pb[2] / pi * sinc(pb[2]*m/pi)
		h = h + temp
		temp = pb[1] / pi * sinc(pb[1]*m/pi)
		h = h - temp
	end

	win = win_fct(L)
	hwin = h .* win


end
