using Plots
plotly()

N = 100_000


u = rand(Float64, N)

# asymmetric triangluar distribution

#a = 2.
#x = sqrt.(a*a.*u)


# histogram(x, nbins=50)


# truncated power-law
alph = 2.0
xmin = 1.8


x = xmin*(-u.+1).^(1/(1-alph))

indclean = findall(e->e<10, x)
xclean = x[indclean]



histogram(xclean, nbins=50)