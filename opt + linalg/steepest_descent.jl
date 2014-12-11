

N = 20

A = [3. 2.;2. 6.]


b = [2., -8.]


x = [0.,0.]

xstore = Array(Float64, 2, N)

for i=1:N

  r = b - A*x

  alpha = (r.'*r) / ( r.' * A * r )

  # some stupid trick to get a scalar out of the 1x1 array
  alpha = alpha[1,1]

  x = x + alpha * r
  xstore[:,i] = x

end


println(xstore)
