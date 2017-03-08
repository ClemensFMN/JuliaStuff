using Gadfly
using DataFrames
using Iterators

N = 5

x = linspace(0,5,N)
y = linspace(0,5,N)

#inval = product(x,y)
#res = [x*y for (x,y) in inval]

inval = zeros(N^2, 2)
c = 1

for i in 1:N
    for j in 1:N
        inval[c,1] = x[i]
        inval[c,2] = x[j]
        c += 1
    end
end

outval = zeros(N^2)

for i in 1:N^2
    outval[i] = inval[i,1]*inval[i,2]
end

df = DataFrame(x=inval[:,1], y=inval[:,2], z=outval)

p = plot(df, x="x", y="y", color="z", Geom.rectbin)

draw(SVG("test.svg",8inch,5inch),p)
