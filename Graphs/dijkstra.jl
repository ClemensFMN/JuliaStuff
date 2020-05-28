using LightGraphs

g = SimpleDiGraph(6)

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

#include("graph_plot.jl")
#plotDirectedGraph(g, weight_mtx)

res = dijkstra_shortest_paths(g, 1, weight_mtx)
println(res.dists[3]) # -> weight from 1 to 3 = 2
println(enumerate_paths(res, 3)) # path from 1 to 3 = 1-2-3
