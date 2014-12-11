

function rand_sym(p)
	F = cumsum(p)
	u = rand()
	for i=1:length(p)
		if(u<F[i])
			return i
		end
	end
end


println(rand_sym([0.3, 0.5, 0.2]))

