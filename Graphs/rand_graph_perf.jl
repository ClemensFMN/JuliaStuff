using LightGraphs, LightGraphsFlows
using Distributions

# test performance of random graph creation and max-flow detemrination.


function runMe(RUNS, p)

    nv = 500
    flow = zeros(RUNS)
    pdist = Uniform(0,1)

    for run in 1:RUNS

        g = erdos_renyi(nv, p, is_directed=true)

        # setup capacity matrix
        capacity_mtx = zeros(nv, nv)
        for e in edges(g)
            # println(e)
            # let's make it simple and assign a capacity of one to every edge
            capacity_mtx[e.src, e.dst] = rand(pdist)
        end

        s = 1
        t = nv

        f, F = maximum_flow(g, s, t, capacity_mtx)
        #@show run, f
        flow[run] = f

    end
    #flow
end


RUNS = 100


@time res=runMe(RUNS, 0.5)
