using Distributions
using Winston


N = int(1e7)

# rejection sampling from distribution p with _proposal size N_
function gen_smpls(p, N)

	ux = Uniform(-10, 10)
	uy = Uniform(0, 1)	

	xu = rand(ux, N)
	yu = rand(uy, N)

	yn = p(xu)

	idx = yu .< yn

	rnds = xu[idx]

end



# we have a model y = x + w
# x \sim N(mu_x, s2_x) and w \sim N(0, s2_w)

s2_w = 0.5
s2_x = 1

mu_x = 1.0

# our observation
y = 1.8

# likelihood function y|x \sim N(y, x, s2_w)
flh = Normal(y, sqrt(s2_w))
# the a priori distribution x \sim N(x, mu_x, s2_x)
fx = Normal(mu_x, sqrt(s2_x))

# use the rejection sampling algorithm.
# to sample from the product of likelhood function \times a priori distribution
# we define fpost as an anonymuous function (depending on x) to represent the product of the 2 pdfs
fpost = x-> pdf(flh,x) .* pdf(fx,x)
rnds = gen_smpls(fpost, N)

println("# Samples: ", length(rnds))

# measured
println(mean(rnds))
println(var(rnds))


# theoretical result
s2_map = 1/(1/s2_w + 1/s2_x)
mu_map = s2_w/(s2_w + s2_x) * mu_x + s2_x/(s2_w + s2_x) * y

println(mu_map)
println(s2_map)

#hst = hist(rnds, 70)

#frm = Winston.FramedPlot(title="", xlabel="x", ylabel="Density")

#Winston.add(frm, Winston.Histogram(hst[1], hst[2], color="red"))


