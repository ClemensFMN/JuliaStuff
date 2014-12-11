using PyCall


function jl_triang(M, sym=true)

	if(M == 1)
		return [1]
	end

	n = 1:ceil(M/2)

	if(M % 2 == 0)
		w = (2*n-1) / M
		w = [w ; reverse(w)]
	end

	collect(w)

end



@pyimport scipy.signal as sig

w = sig.triang(10, sym=true)

println(w)

w = jl_triang(10)

println(w)
