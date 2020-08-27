using LightGraphs, LightGraphsFlows
using Distributions
using PlotlyJS

function runMe(RUNS, p)

    nv = 100
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
    flow
end


pvec = [0.1 0.5]#0.1:0.1:1
RUNS = 10000
res = zeros(length(pvec), RUNS)

for (ind, p) in enumerate(pvec)
    @show ind, p
    posflow = runMe(RUNS, p)
    res[ind,:] = posflow
end

# plot(pvec, res)

h1=histogram(x=res[1,:], type="histogram", name="p=0.1")
h2=histogram(x=res[2,:], type="histogram", name="p=0.5")
plot([h1, h2])
