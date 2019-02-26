

# actually inspired by Euler Problem #233
# we consider a circle centered @ 0/0 and radius N
# i.e. x^2 + y^2 = N^2
# how many integer lattice points are on the circle?


function cnt_lattice_points(N)

	cnt = 0
	for x = 1:N-1 # we do not include the x=0 and x=N as we multiply the rational points by 4 and add 4
		y = sqrt(N^2 - x^2)
		#println(x, " -> ", y)
		if(floor(y) == y)
			cnt += 1
		end
	end
	# we have a four-fold symmetry; i.e. if (x,y) is on the circle, so are (x,-y), (-x,y) & (-x,-y)
	cnt = cnt * 4
	# and finally we have the four coner points (0,N), (0,-N), (N,0) & (-N,0)
	cnt = cnt + 4

	return(cnt)

end

cnt_res = Dict{Int64, Int64}()

for N = 2:20_000

	cnt = cnt_lattice_points(N)
	#println(N, " --> ", cnt)

  cnt_res[N] = cnt

end

findmax(cnt_res)
