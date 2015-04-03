# include("contour.jl")

using Winston

x = [-3:0.01:3]
y = [-3:0.01:3]

#z = [(xi^2 + yi^2)::Float64 for xi in x, yi in y]

h = [-5:0.5:5]


z = [(1/sqrt((xi-0.5)^2 + yi^2) - 1/sqrt((xi+0.5)^2 + yi^2))::Float64 for xi in x, yi in y]

c = contours(x, y, z, h)


p = FramedPlot()


for hitem in 1:length(h)
	
	xs, ys = coordinates(c[hitem].lines[1])
	add(p, Curve(xs, ys))

end

display(p)


