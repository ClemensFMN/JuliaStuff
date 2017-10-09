function escape(c)
	z = 0
	for iter=0:40

		z = z^2 + c
		if(norm(z) > 4.0)
			return(iter)
		end
	end
	return(0)
end


N = 500
#cvecx = cvecy = linspace(-2.0, 2.0, N)
# detail
cvecx = linspace(-2, -1, N)
cvecy = linspace(-0.5, 0.5, N)
region = zeros(N, N)


for (xiter, xval) in enumerate(cvecx)
    for (yiter, yval) in enumerate(cvecy)
        region[xiter, yiter] = escape(xval + yval*1im)
    end
end




using Plots
plotly()

contour(cvecx, cvecy, region)




