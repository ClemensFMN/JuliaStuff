


function newton_solve(z0)
# solve x^2 - 4 = 0
	z = z0
	for n=1:20
		z = z - (z*2-4)/(2*z)
		println(n, " -> ", z)
	end
	return z
end


println(newton_solve(4))
