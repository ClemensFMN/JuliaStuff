


A = [3. 2.; 2. 6.]

b = [2.;-8.]


x = [0.;0.]

d = b - A*x
r = d


for i=1:10


	alpha = (r.' * r) / (r.' * A * r)

	alpha = alpha[1,1]

	x = x + alpha * d

	println(norm(x - [2;-2]))

	rnew = r - alpha * A * d
	beta = (rnew.' * rnew) / (r.' * r)

	beta = beta[1,1]

	d = rnew + beta * d
	r = rnew

end


