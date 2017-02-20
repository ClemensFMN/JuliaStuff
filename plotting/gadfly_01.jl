using Gadfly
using DataFrames

# this seems to be the normal way to plot several functions in the same plot within one plot

x = linspace(-2,2,20)
y1 = x
y2 = x.^2

# every plot is contained within one DataFrame
# the x values are in x, the y values are in y, Function can be anything
df1 = DataFrame(x=x,y=y1,Function="y1")
df2 = DataFrame(x=x,y=y2,Function="y2")

# we merge the two DataFrames together
# take a look on the console, but we have now a table with three columns
# x,y, and Function
df = vcat(df1, df2)

# we say that we want to plot y vs x and select the line color based on the Function attribute
p = plot(df, x=:x,y=:y, color=:Function, Geom.point, Geom.line)

draw(SVG("test.svg",4inch,3inch),p)
