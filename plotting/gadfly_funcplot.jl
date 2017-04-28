using Gadfly
using DataFrames

function totient(n)
  val = sum(i->gcd(i,n)==1,1:n)
end

# this seems to be the normal way to plot several functions in the same plot within one plot

# x = linspace(-2,2,20)
xval = 1:50
y1 = zeros(50)
for x in xval
   y1[x] = totient(x)
end
   
y2 = xval - 1

# every plot is contained within one DataFrame
# the x values are in x, the y values are in y, Function can be anything
df1 = DataFrame(x=xval,y=y1,Function="Phi(x)")
df2 = DataFrame(x=xval,y=y2,Function="Upper Bound")

# we merge the two DataFrames together
# take a look on the console, but we have now a table with three columns
# x,y, and Function
df = vcat(df1, df2)

# we say that we want to plot y vs x and select the line color based on the Function attribute
# p = plot(df, x=:x,y=:y, color=:Function, Geom.point)
p = plot(
     layer(x=xval,y=y1, Geom.point, Theme(default_color=color("red"))),
     layer(x=xval,y=y2, Geom.line, Theme(default_color=color("blue"))))

draw(PNG("euler_phi.png",7inch,5inch),p)
