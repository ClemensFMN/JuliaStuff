using Flux

f1(x) = 3*x^2 - 2*x + 1
@show f1(2) # 3*2^2- 2*2 + 1 = 9

# taking "gradient" of a scalar function
df1(x) = gradient(f1, x) #6x - 2
@show df1(2)  # 6*2 - 2 = 10

# now a bit more complex
f2(x,y) = x^2 + 3*x*y - 2*y^2 + 1
@show f2(3,4) # 3^2 + 3*3*4 - 2*4^2 + 1 = 14

df2(x,y) = gradient(f2,x,y) # [2x+3y, 3x-4y]
@show df2(3,4) # [2*3 + 3*4, 3*3 - 4*4] = [18, -7]

# we can differentiate "everything", even more complex stuff
mysin(x) = sum((-1)^k*x^(1+2k)/factorial(1+2k) for k in 0:5)
x = 0.5
@show mysin(x), gradient(mysin, x)
@show sin(x), cos(x)

# and finally also functions which take vector-valued inputs
myloss(W, b, x) = sum(W * x .+ b)

W = randn(3, 5)
b = zeros(3)
x = rand(5)

dmyloss = gradient(myloss, W, b, x)
@show dmyloss