using Plots
plotly()
using Distributions

# More special topics...

x = linspace(1,10)
y = exp.(x)
plot(x,y,yscale=:log10)

x = randn(10000)
histogram(x, bins=50)

# partly based on https://juliaplots.github.io/examples/plotlyjs/

x = randn(10000); y = randn(10000)
histogram2d(x,y,nbins=50)

# MVNormal with diagonal covariance
p1 = MvNormal([1.0, 0.5], [1.0, 1.0])
x = rand(p1, 1000000)
histogram2d(x[1,:], x[2,:], nbins=50)

p2 = MvNormal([1.0, 0.5], [1.0 0.8; 0.8 1.0])
x = rand(p2, 1000000)
histogram2d(x[1,:], x[2,:], nbins=50)


y = randn(10)
plot(y)
annotate!([(3,y[3],text("Hello", :left))])


x = linspace(-5,5)
y = linspace(-5,5)
f(x,y) = begin
   x.^2 + y.^2
end

X = repmat(x',length(y),1)
Y = repmat(y,1,length(x))
Z = map(f,X,Y)
p1 = contour(x,y,f,fill=true)
plot(p1)

t = linspace(0, 8*pi,500)
x = cos(t)
y = sin(t)
z = t
plot(x,y,z)
