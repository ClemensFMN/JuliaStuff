using Gadfly
using Distributions
using DataFrames

#pdf = Normal(1.0, 2.0)
#x = rand(pdf, 10000)
#p = plot(x=x, Geom.histogram(bincount=60, density=true))

#draw(SVG("test.svg",7inch,5inch),p)



pdf1 = Normal(5.0, 2.0)
pdf2 = Normal(-5.0, 2.0)

x1 = rand(pdf1, 10000)
x2 = rand(pdf2, 10000)

df1 = DataFrame(x=x1, RV = "x1")
df2 = DataFrame(x=x2, RV = "x2")

df = vcat(df1, df2)

# funnny one - we can either plot the histogram of all x
p = plot(df, x=:x, Geom.histogram(bincount=40))
# or draw separate histograms depending on the RV attribute...
# p = plot(df, x=:x, color=:RV, Geom.histogram(bincount=40))

draw(SVG("test.svg",7inch,5inch),p)
