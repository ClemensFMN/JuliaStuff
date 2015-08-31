function cdf(xlim, mu, s2)

	0.5*(1+erf((xlim-mu)/(sqrt(2*s2))))

end


# generate N random normal RVs
N = 1000000

# with variance s2
s2 = 1.5

x = sqrt(s2)*randn(N)

# find the prob of X < xlim
xlim = 1.2
k = 3

# empirically
println(count(x->x<xlim, x)/N)

# with the error function
trueval = 0.5*(1+erf(xlim/(sqrt(2*s2))))
println(trueval)

# find the prob of a < X < b
a = -3
b = 1

# empirically
println(count(x->x>a && x<b, x)/N)

# with the error function
trueval = cdf(b, 0, s2) - cdf(a, 0, s2)
println(trueval)


# find the prob of X > a
a = 0.4


# empirically
println(count(x->x>a, x)/N)

# with the error function
trueval = 1 - cdf(a, 0, s2)
println(trueval)



# find the prob that abs(X) > xlim
# empirically

#println(count(x->abs(x)>k*sqrt(s2), x)/N)

# using the error function
#trueval = (1+erf(-k*sqrt(s2)/(sqrt(s2)*sqrt(2))))
#println(trueval)

# chebyshev inequality
#println(1/k^2)





