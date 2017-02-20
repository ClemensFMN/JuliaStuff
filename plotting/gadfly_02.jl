using Gadfly
using DataFrames

# this seems to be the normal way to plot several functions in the same plot within one plot

x = linspace(-2,2,20)
y1 = x
y2 = x.^2

# every plot is contained within one DataFrame
# we can give the columns different names (which are then used in the plot)
df1 = DataFrame(xValues=x,yValues=y1,Function="y1")
df2 = DataFrame(xValues=x,yValues=y2,Function="y2")

# we merge the two DataFrames together
df = vcat(df1, df2)

# we say that we want to plot y vs x and select the line color based on the Function attribute
# x and y must be defined, but we can use other names in the DataFrames
p = plot(df, x=:xValues,y=:yValues, color=:Function, Geom.point, Geom.line)

draw(SVG("test.svg",4inch,3inch),p)
