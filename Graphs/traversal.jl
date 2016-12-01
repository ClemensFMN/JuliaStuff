using LightGraphs


g = Graph(5)
add_edge!(g,1,2)
add_edge!(g,1,3)
add_edge!(g,1,5)
add_edge!(g,2,5)
add_edge!(g,3,5)
add_edge!(g,4,5)


println(collect(edges(g)))

bfs = bfs_tree(g,1)
println(collect(edges(bfs)))

dfs = dfs_tree(g,1)
println(collect(edges(dfs)))