using Distributions
using Winston


# rejection sampling from distribution p with _proposal size N_
function gen_smpls(p, N)

	ux = Uniform(-7, 7)
	uy = Uniform(0, 1)	

	xu = rand(ux, N)
	yu = rand(uy, N)

	yn = pdf(p, xu)

	idx = yu .< yn

	rnds = xu[idx]

end

N = int(1e6)

# from this distribution
n = TriangularDist(-2, 3) #Normal(0, 2)
rands = gen_smpls(n, N)

println("Efficiency: ", length(rnds) / N)

hst = hist(rnds, 70)

frm = Winston.FramedPlot(title="", xlabel="x", ylabel="Density")

Winston.add(frm, Winston.Histogram(hst[1], hst[2], color="red"))

