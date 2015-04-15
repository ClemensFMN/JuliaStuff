using Distributions
using Winston

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


# we have a model y = x + w
# x \sim N(mu_x, s2_x) and w \sim N(0, s2_w)

s2_w = 0.5
s2_x = 1

mu_x = 1.0

# our observation
y = 1.8

N = int(1e6)

# likelihood function y|x \sim N(y, x, s2_w)
flh = Normal(y, sqrt(s2_w))
# the a priori distribution x \sim N(x, mu_x, s2_x)
fx = Normal(mu_x, sqrt(s2_x))

# use a mcmc to sample from the product of likelhood function \times a priori distribution
# we define fpost as an anonymuous function (depending on x) to represent the product of the 2 pdfs
fpost = x-> pdf(flh,x) .* pdf(fx,x)
rnds = mcmc(fpost, N)

# measured
println(mean(rnds))
println(var(rnds))


# theoretical result
s2_map = 1/(1/s2_w + 1/s2_x)
mu_map = s2_w/(s2_w + s2_x) * mu_x + s2_x/(s2_w + s2_x) * y

println(mu_map)
println(s2_map)



