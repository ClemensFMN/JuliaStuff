using LightGraphs

# connectedness of random (erdos-renyi) graph

N = 1000
RUNS = 100

# threshold is p_star = log(N)/N
# p < p_star -> not connected
# p > p_star -> connected

println(log(N)/N)


pvec = linspace(0,0.015,21)

for p in pvec

    res = []

    for r in 1:RUNS

        g = erdos_renyi(N, p)
    	append!(res, is_connected(g))

    end

    #println(p, res)
    cncted = count(p->(p==true), res)
    println(p, "...", 100 * cncted / RUNS)

end