using LightGraphs


g = Graph(4)

add_edge!(g,1,2)
add_edge!(g,2,3)
add_edge!(g,3,4)
add_edge!(g,1,3)

weight_mtx = [0  1 10 1
              1  0  1 1
              10 1  0 1
              1  1  1 0]

res = kruskal_mst(g, weight_mtx)
println(res)
