using Distributions
using Winston


N = 10
RUNS = int(5e4)
r = 1.0

pdf_exp = Exponential(r)

# interarrival times have exponential distribution
interarrivals = rand(pdf_exp, (N, RUNS))

# the arrival times are the sum of the interarrival times
arrivals = cumsum(interarrivals)

# the arrival time of the N-th arrival
TN = arrivals[N,:]

print(mean(TN), "  ", r*N)

e, cnt = hist(TN', 60)

plot(e, cnt')
grid(true)

savefig("arrivals_$N.png")

