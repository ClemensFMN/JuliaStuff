using Primes
using Plots
plotly()

# let's count primes in a certain range

cnt = []
strt = []
bns = [1, 2, 5, 10]


for k = 3:9
    for ind in 1:3
        lw = bns[ind] * 10^k
        hgh = bns[ind+1] * 10^k
        @show lw, hgh
        prms = primes(lw, hgh)

        push!(cnt, length(prms) / (hgh - lw))
        push!(strt, lw)
    end
end

scatter(strt, cnt, xscale=:log10)
