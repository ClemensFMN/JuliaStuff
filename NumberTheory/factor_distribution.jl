using Primes
using Plots
plotly()

# let's consider numbers in the range 10_000 - 100_000
range = 10_000 : 100_000

RUNS = 10000

cnt = zeros(RUNS)

for k = 1:RUNS
    num = rand(range)
    fcts =factor(Vector, num) # we ar einterested in the number of total factors, therefore we want an array of factors
    # @show fcts
    cnt[k] = length(fcts)

end

histogram(cnt, bins=1:20)
