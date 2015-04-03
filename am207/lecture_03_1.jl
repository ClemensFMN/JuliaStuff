using Winston


runs = 500
pi_hat = zeros(runs)

for i in 1:runs

	N = int(1e4)

	x = 2*rand(N)-1
	y = 2*rand(N)-1


	dist = x.^2 + y.^2

	inside = sum(dist .< 1.0)

	pi_hat[i] = inside / N * 4

end

p = Winston.FramedPlot(title="", xlabel="x", ylabel="Density")
pi_hist = hist(pi_hat, 50)

Winston.add(p, Winston.Histogram(pi_hist...))



