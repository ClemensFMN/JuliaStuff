using Winston

N = 6
srand(1234)


x = linspace(-2,2,N)

y = x.^3

yobs = y + 1*randn(N,1)

A1 = [x.^0 x.^1]
A3 = [x.^0 x.^1 x.^2 x.^3]
A5 = [x.^0 x.^1 x.^2 x.^3 x.^4 x.^5]


c_hat_1 = inv(A1'*A1)*A1'*yobs
c_hat_3 = inv(A3'*A3)*A3'*yobs
c_hat_5 = inv(A5'*A5)*A5'*yobs


plot(x,yobs,"-rx", x,A1*c_hat_1,"ob", x,A3*c_hat_3,"og", x,A5*c_hat_5,"+y")
# legend(["Observation", "N = 1", "N = 3", "N = 5"])
savefig("ls_polyfit_with_noise.pdf")


