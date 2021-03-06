using Distributions
using Plots
plotly()

struct Point
    x :: Float64
    y :: Float64
end

function plotPoints(ps, pshull)
	xs = [p.x for p in ps]
	ys = [p.y for p in ps]
	scatter(xs, ys) # scatter-plot all point

	xs = [p.x for p in pshull]
	ys = [p.y for p in pshull]
	# push the first point to the end to "close" the hull
	push!(xs, xs[1])
	push!(ys, ys[1])
	plot!(xs, ys) # plot via line the convex hull
end


function rPoints(n, seed=42)
	p1 = Uniform(0,3)
	p2 = Uniform(0,2)
	res = Vector{Point}(undef,n)
	for i=1:n
		res[i] = Point(rand(p1), rand(p2))
		
	end
	res
end

function turn(A, B, C)
	diff = (B.x - A.x) * (C.y - B.y)  -  (B.y - A.y) * (C.x - B.x) 
    if(diff < 0)
    	:right
    elseif(diff > 0)
    	:left
    else
    	:straight
    end    
end

# testing
#A = Point(0,0)
#B = Point(1,0)
#Cl = Point(2,1)
#Cr = Point(2,-1)
#Cs = Point(2,0)

#println(turn(A,B,Cl))
#println(turn(A,B,Cr))
#println(turn(A,B,Cs))


function half_hull(spoints)
	hull = Vector{Point}()
	for C in spoints
		while((length(hull) >= 2) && (turn(hull[end-1], hull[end], C) != :left))
			pop!(hull)
		end
		push!(hull, C)
	end
	hull
end


function convex_hull(points)
	if(length(points) < 4)
		return points
	end
	upper = half_hull(sort(points, by=p->p.x))
	lower = half_hull(reverse(sort(points, by=p->p.x)))

	res = vcat( upper, lower[2:end-1])
	return (res, length(res) / length(points))
end

ps = rPoints(10)

hull = convex_hull(ps)

# plotPoints(hull[1])

nPoints = 10 .^(1:0.1:4)
ln = length(nPoints)
ratio = zeros(ln)

RUNS = 100

for (ind, num) in enumerate(nPoints)
	res = zeros(RUNS)
	for i=1:RUNS
		ps = rPoints(convert(Int64, ceil(num)))
		_, r = convex_hull(ps)
		res[i] = r
	end
	ratio[ind] = mean(res)
end

plot(nPoints, ratio, yscale=:log10, xscale=:log10)
