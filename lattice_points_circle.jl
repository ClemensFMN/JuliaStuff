

# actually inspired by Euler Problem #233
# we consider a circle centered @ 0/0 and radius N
# i.e. x^2 + y^2 = N^2
# how many integer lattice points are on the circle?


function cnt_lattice_points(N)

	cnt = 0
	for x = 1:N-1
		y = sqrt(N^2 - x^2)
		#println(x, " -> ", y)
		if(floor(y) == y) then
			cnt += 1
		end
	end
	# we have a four-fold symmetry; i.e. if (x,y) is on the circle, so are (x,-y), (-x,y) & (-x,-y)
	cnt = cnt * 4
	# and finally we have the four coner points (0,N), (0,-N), (N,0) & (-N,0)
	cnt = cnt + 4

	return(cnt)

end



for N = 1:20

	cnt = cnt_lattice_points(N)
	println(N, " --> ", cnt)

end
