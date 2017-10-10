using Gadfly
using Distributions

X = rand(MultivariateNormal([0.0, 0.0], [1.0 1.39; 1.39 2.0]), 10000);
p = plot(x=X[1,:], y=X[2,:], Geom.hexbin(xbincount=100, ybincount=100))


draw(SVG("test.svg",7inch,5inch),p)
