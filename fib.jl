

N = 50
M = 3

fib = Array(Int, N)
fib_mod = Array(Int, N)

fib[1] = 1
fib[2] = 1
fib_mod[1] = 1
fib_mod[2] = 1


for i in 3:N

	fib[i] = fib[i-1] + fib[i-2]
	fib_mod[i] = mod(fib[i], M)

end

println(fib)
println(fib_mod)


