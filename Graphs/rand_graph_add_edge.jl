using LightGraphs, LightGraphsFlows
using Distributions
using Plotly

function runMe(p, RUNS, naddedges)

    nv = 100
    # pdist = Uniform(0,1)
    flow = zeros(RUNS)
    flowadd = zeros(RUNS)

    for run in 1:RUNS

        g = erdos_renyi(nv, p, is_directed=true)

        # setup capacity matrix
        capacity_mtx = zeros(nv, nv)
        for e in edges(g)
            # println(e)
            # let's make it simple and assign a capacity of one to every edge
            capacity_mtx[e.src, e.dst] = 1 #rand(pdist)
        end

        s = 1
        t = nv

        f, F = maximum_flow(g, s, t, capacity_mtx)
        #@show run, f
        flow[run] = f

        for i in 1:naddedges
            u = rand(1:nv)
            v = rand(1:nv)
            add_edge!(g, u, v)
            capacity_mtx[u, v] = 1
        end

        f, F = maximum_flow(g, s, t, capacity_mtx)
        #@show run, f
        flowadd[run] = f
        
    end
    flow, flowadd
end


pvec = [0.1] # 0:0.05:1 #0:0.001:0.1
RUNS = 50000
res = zeros(length(pvec), RUNS)
resadd = zeros(length(pvec), RUNS)

for (ind, p) in enumerate(pvec)
    @show ind, p
    res[ind,:], resadd[ind,:] = runMe(p, RUNS, 1000)
end

println(mean(res))
println(mean(resadd))


h1=histogram(x=res[1,:], type="histogram", name="Initial Graph")
h2=histogram(x=resadd[1,:], type="histogram", name="Additional Edges")
plot([h1, h2])
