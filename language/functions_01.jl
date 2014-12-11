

function f(x,y)

	return x+y, x*y

end

x,y=f(2,5)


function dflt_arg(x, y=10)

	return x*y

end

dflt_arg(2)
dflt_arg(2,2)


function named_arg(x; factor=2)

	return x*factor

end


named_arg(2)
named_arg(2, factor=30)


function floatFunc(x::FloatingPoint)

	return x*x

end

floatFunc(3.45)

