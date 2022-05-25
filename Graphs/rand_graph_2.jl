using LightGraphs, LightGraphsFlows
using Distributions
using Plotly

function runMe(p)

    nv = 100
    RUNS = 100
    pdist = Uniform(0,1)
    flow = zeros(RUNS)

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
    # how often do we get a flow > 0?
    # posflow = length(findall(x -> x > 0, flow)) / RUNS
    # what is the average value of a flow if it exists
    ind = findall(x -> x > 0, flow)
    mean(flow[ind])
end


pvec = 0:0.05:1 #0:0.001:0.1
res = zeros(length(pvec))

for (ind, p) in enumerate(pvec)
    @show ind, p
    posflow = runMe(p)
    res[ind] = posflow
end

# plot(pvec, res)

