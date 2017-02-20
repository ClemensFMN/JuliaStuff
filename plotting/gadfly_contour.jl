using Gadfly


p = plot(z=(x,y) -> x^2 + y^2,
     x=linspace(-5,5,150), y=linspace(-5,5,150), Geom.contour)


draw(SVG("test.svg",7inch,5inch),p)
