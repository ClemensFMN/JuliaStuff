using Distributions
using Winston

# simple MCMC - proof of concept...

function mcmc(p, N)
	# proposal distribution
	delta = 0.5
	qd = x -> x + rand(Uniform(-delta, delta))

	x0 = qd(0)
	x = zeros(N)
	x_prev = x0
	for i=1:N

		x_star = qd(x_prev)
		P_star = p(x_star)
		P_prev = p(x_prev)

		U = rand(Uniform(0,1))
		A = min(1, P_star / P_prev)

		if(U<=A)
			x[i] = x_star
			x_prev = x_star
		else
			x[i] = x_prev
			x_prev = x_prev
		end
	end

	x

end

# the target distribution
pd = Normal()
p = x -> pdf(pd, x)

N = int(1e6)

# generate N samples from the target distribution
x = mcmc(p, N)

hst = hist(x, 70)
frm = Winston.FramedPlot(title="", xlabel="x", ylabel="Density")
#Winston.add(frm, Winston.Histogram(hst[1], hst[2], color="red"))
Winston.add(frm, Curve(1:200, x[1:200]))
