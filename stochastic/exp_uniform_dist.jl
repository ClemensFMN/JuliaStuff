using Distributions
using StatsBase
using Plots
plotly()
using SpecialFunctions

# we x disitrubted with an exponential distribution; x \sim ae^{-ax}
# but a is not constant but also random: a \sim Uniform(1,2)
# generate random x values and determine P(X > b) 
N = 500

A = 1
B = 2

# the distrubtion for a
pa = Uniform(A,B)

a = rand(pa, N)
# for every random a, we generate N values
x = zeros(N,N)

for (ind, ascalar) in enumerate(a)
	# generate the random x's
	px = Exponential.(1/ascalar) # careful, Distributions defines exponential with 1/a
	# and stuff them into the i-th row of the result matrix
	x[ind,:] = rand.(px, N)
end

# "flatten" the matrix
x = x[:]

L = 1
# and find P(X > L)
ind = findall(e -> e > L, x)
println(length(ind) / N^2)



pe1 = Exponential(1)
e1 = rand(pe1, 50000)
pe2 = Exponential(1/2)
e2 = rand(pe2, 50000)

edges = 0:0.1:4

hx = fit(Histogram, x, edges)
he1 = fit(Histogram, e1, edges)
he2 = fit(Histogram, e2, edges)

plot(edges[1:end-1], [hx.weights./sum(hx.weights), he1.weights./sum(he1.weights), he2.weights./sum(he2.weights)], seriestypes=:scatter, label=["X" "Exp., a=1" "Exp, a=2"])
# histogram([x, e1, e2], normalize=:probability, fillalpha=0.5, label=["x" "e1" "e2"], bins=range(0,5,length=25), line=(1, 0.2,:green))
