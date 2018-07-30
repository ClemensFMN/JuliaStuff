

N = 50
M = 3

fib = Array{Int}(N)
fib_approx = Array{Float64}(N)
fib_sum_approx = Array{Float64}(N)
fib_even_sum_approx = Array{Float64}(N)
fib_mod = Array{Int}(N)

fib[1] = 1
fib[2] = 1
fib_mod[1] = 1
fib_mod[2] = 1

A = (1+sqrt(5))/2
B = (1-sqrt(5))/2

for i in 3:N

	fib[i] = fib[i-1] + fib[i-2]
  fib_mod[i] = mod(fib[i], M)

end

for i in 1:N

  fib_approx[i] = 1/sqrt(5)*(A^i) #-B^i)
  fib_sum_approx[i] = 1/sqrt(5)*(A - A^(i+1))/(1-A)
  fib_even_sum_approx[i] = 1/sqrt(5)*(A^3 - A^(3*(i+1)))/(1-A^3)
	

end

# println(fib)
# println(fib_mod)

fib_sum = cumsum(fib)

# [fib_sum fib_sum_approx]

fib_even = filter(iseven, fib)

# cumsum(fib_even)

