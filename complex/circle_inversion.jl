using Gadfly
using DataFrames


r = 0.2

u = 0.3 + .5im

phi = linspace(0, 2*pi, 100)

z = u + r * exp(1im*phi)
ztilde1 = 1 ./ z #conj(z)
ztilde2 = 1 ./ conj(z)

df1 = DataFrame(x = real(z), y = imag(z), Function="z")
df2 = DataFrame(x = real(ztilde1), y = imag(ztilde1), Function="1/z")
df3 = DataFrame(x = real(ztilde2), y = imag(ztilde2), Function="1/conj(z)")

df4 = DataFrame(x = real(ztilde2 - 1/u), y = imag(ztilde1 - 1/u), Function="centered")

df = vcat(df1, df2, df3, df4)


p = plot(df, x=:x, y=:y, color=:Function, Geom.point)#, Coord.Cartesian(fixed=true))

draw(SVG("circle_inversion.svg", 8inch, 8inch),p)

# the 1/z circe should be centered at 1/u -> subtract this and the abs value should be constant
# but it is not... Hm...
println(abs(ztilde1 - 1/u))

# on the other hand, the difference between 1/u and mean(ztilde1) is also rather small...
println(1/u)
println(mean(ztilde1))


# i *think* that this is a numerical / whatever issue and nothing fundamental
# would be interesting to evaluate analytically the expression
# Real(1/(u + r*e^{j\phi}) - 1/u)^2 + Imag(1/(u + r*e^{j\phi}) - 1/u)^2
# I would assume that this gives a constant expression; i.e. x^2 + y^2 = R^2 -> we have a circle
