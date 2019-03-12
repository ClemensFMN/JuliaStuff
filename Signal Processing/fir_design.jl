using Winston
include("dsp_stuff.jl")


function fir_window_design(L :: Int64, passbands :: Array{Float64,2}, win_fct :: Function)

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



type Passband
	attn :: Float64
	start :: Float64
	stop :: Float64
end


function fir_window_design(L :: Int64, passbands :: Array{Passband,1}, win_fct :: Function)

	m = [0:L-1] - (L-1)/2

	npbs = length(passbands)

	h = zeros(L)

	for i in 1:npbs
		
		pb = passbands[i]
		temp = pb.attn * pb.stop / pi * sinc(pb.stop*m/pi)
		h = h + temp
		temp = pb.attn * pb.start / pi * sinc(pb.start*m/pi)
		h = h - temp
	end

	win = win_fct(L)
	hwin = h .* win

end


