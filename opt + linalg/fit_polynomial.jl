

function polyfit(x, y, n)
  A = [ float(x[i])^p for i = 1:length(x), p = 0:n ]
  A \ y
end


function polyval(x,p)
	yhat = 0
	for i=2:N+1
		yhat = yhat + p[i] * x.^(i-1)
	end
	yhat = yhat + p[1]
end

x = 0:10
y = 1+3*x.^2 # + randn()

println(y)

N = 2

p = polyfit(x,y,N)

println(p)


yhat = polyval(x,p)

println(norm(yhat-y))


