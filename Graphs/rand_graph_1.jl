using LightGraphs, LightGraphsFlows
using Distributions
include("graph_plot.jl")

# random graph with 10 vertices and 5 edges
#g = SimpleDiGraph(10,5)

nv = 10
g = erdos_renyi(nv, 0.2, is_directed=true)

println(collect(edges(g)))

# setup capacity matrix
p = Uniform(0,1)
capacity_mtx = zeros(nv, nv)
for e in edges(g)
    # println(e)
    capacity_mtx[e.src, e.dst] = rand(p)
end

s = 1
t = nv

f, F = maximum_flow(g, s, t, capacity_mtx)
# plotDirectedGraph(g, capacity_mtx)
gplothtml(g, nodelabel=1:nv)
