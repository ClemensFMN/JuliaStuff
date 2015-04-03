using Distributions
using Winston


function auc(h::(Range{Float64},Array{Int64,1}))
  freq=convert(Array{Float64,1},h[2])
  e=convert(Array{Float64,1},h[1])
  numbins=length(e)
  deltax=e[2:numbins]-e[1:(numbins-1)]
  sum(deltax.*freq)
end;


N = int(1e4)

# integrate from a ... b
a = -1
b = 1

runs = 1000

I_hat = zeros(runs)
I_hat_2 = zeros(runs)

for i in 1:runs

	p = Uniform(a, b)

	x = rand(p, N)


	# the values of the function 1 - x^2
	fxi = 1-x.^2

	# exact value is 4/3
	I_exact = 4/3

	I_hat[i] = (b-a)/N*sum(fxi)


	p = Normal(0, 0.5)
	ptrunc = Truncated(p, a, b)

	x = rand(ptrunc, N)

	fxi = 1-x.^2
	I_hat_2[i] = mean(fxi ./ pdf(ptrunc, x))

end

#println("I_hat: ", I_hat)
#println("I_hat_2: ", I_hat_2)


p = Winston.FramedPlot(title="", xlabel="x", ylabel="Density")
I_1_hist = hist(I_hat, 30)
I_2_hist = hist(I_hat_2, 30)

Winston.add(p, Winston.Histogram(I_1_hist[1], I_1_hist[2] / auc(I_1_hist), color="red"))
Winston.add(p, Winston.Histogram(I_2_hist[1], I_2_hist[2] / auc(I_2_hist), color="green"))

