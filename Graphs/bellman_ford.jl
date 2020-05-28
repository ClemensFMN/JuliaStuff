using LightGraphs
using GraphPlot

g = Graph(6)

add_edge!(g,1,2)
add_edge!(g,1,3)
add_edge!(g,1,4)
add_edge!(g,2,3)
add_edge!(g,3,4)
add_edge!(g,3,5)
add_edge!(g,3,6)
add_edge!(g,5,6)

#             1  2  3  4  5  6
weight_mtx = [0  1  3  2  0  0  # 1
              0  0  1  0  0  0  # 2
              0  0  0  2  3  6  # 3
              0  0  0  0  0  0  # 4
              0  0  0  0  0  1  # 5
              0  0  0  0  0  0] # 6

weight_mtx = (weight_mtx + weight_mtx')

# run bellman ford algorithm starting at vertex 1
# it return dists & parents
res = bellman_ford_shortest_paths(g, 1, weight_mtx)

println(res.dists[3]) # -> 2

# we can use enumerate_paths to obtain the path between the source vertex & one/several/all vertices
println(enumerate_paths(res, 3)) # -> path between 1 & 3 = 1-2-3

# use stuff from graph plot
include("graph_plot.jl")
# to plot the graph
plotUndirectedGraph(g, weight_mtx)
