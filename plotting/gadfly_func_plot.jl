using Gadfly
using DataFrames

function euler_phi(n)

   val = sum(i->gcd(i,n)<2,1:n)
   return(val)

end


# this seems to be the normal way to plot several functions in the same plot within one plot

x = linspace(0,20,20)
y1 = x
# y2 = x.^2

# every plot is contained within one DataFrame
# we can give the columns different names (which are then used in the plot)
df1 = DataFrame(xValues=x,yValues=y1,Function="y1")
#df2 = DataFrame(xValues=x,yValues=y2,Function="y2")

# we merge the two DataFrames together
df = df1 #vcat(df1, df2)

# we say that we want to plot y vs x and select the line color based on the Function attribute
# x and y must be defined, but we can use other names in the DataFrames
p = plot(df, x=:xValues,y=:yValues, color=:Function, Geom.point, Geom.line)

draw(PNG("euler_phi.png",7inch,5inch),p)
