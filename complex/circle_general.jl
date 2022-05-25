using Gadfly
using DataFrames


phi = linspace(0, 2*pi, 100)

z0 = 0.2-0.6im
r = 1.2

w1 = (conj(z0) + r*exp(-1im*phi)) ./ (abs(z0)^2 + r^2 + 2*real(z0*r*exp(-1im*phi)))
w2 = (z0 + r*exp(1im*phi)) ./ (abs(z0)^2 + r^2 + 2*real(conj(z0)*r*exp(1im*phi)))


df1 = DataFrame(x = real(w1), y = imag(w1), Function="1/z")
df2 = DataFrame(x = real(w2), y = imag(w2), Function="1/conj(z)")


df = vcat(df1, df2)


# p = plot(df, x=:x, y=:y, color=:Function, Geom.point, Coord.Cartesian(xmin=-0.7, ymin=-0.7, xmax=0.7, ymax=0.7))

p = plot(df, x=:x, y=:y, color=:Function, Geom.point, Coord.Cartesian(fixed=true))

draw(SVG("circle_general.svg", 8inch, 8inch),p)


