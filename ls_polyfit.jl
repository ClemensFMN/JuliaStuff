using Winston

N = 6
srand(1234)


x = linspace(-2,2,N)

y = x.^3

yobs = y + 1*randn(N,1)

# A = [x.^0 x.^1]
A = [x.^0 x.^1 x.^2 x.^3]
# A = [x.^0 x.^1 x.^2 x.^3 x.^4 x.^5]


c_hat = inv(A'*A)*A'*yobs


plot(x,yobs,"-rx", x,A*c_hat,"ob")
savefig("order3.png")


