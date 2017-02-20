using Gadfly
using DataFrames


x = linspace(0,2,50)
y1 = x
y2 = x.^2

df1 = DataFrame(x=x,y=y1,label="y1")
df2 = DataFrame(x=x,y=y2,label="y2")


df = vcat(df1, df2)

p = plot(df, x=:x,y=:y, color=:label, Geom.line)

draw(SVG("test.svg",4inch,3inch),p)
