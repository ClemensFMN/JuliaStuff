using Graphs


type LogGraphVisitor <: AbstractGraphVisitor
end

function discover_vertex(vis::LogGraphVisitor, v)
    println("discover vertex: $v")
    true
end


g = graph([1,2,3,4,5,6], [Edge(1,1,3), Edge(2,1,4), Edge(3,1,2), Edge(4,2,4), Edge(5,3,5), Edge(6,3,6)], is_directed=false)

#g = simple_graph(6, is_directed=false)

# add_edge!(g, 1, 3)
# add_edge!(g, 1, 4)
# add_edge!(g, 1, 2)
# add_edge!(g, 2, 4)
# add_edge!(g, 3, 5)
# add_edge!(g, 3, 6)

println(edges(g))


println(adjacency_matrix(g))
println(out_degree(1, g))


println(visited_vertices(g, DepthFirst(), 1))

println(visited_vertices(g, BreadthFirst(), 1))

#visitor::LogGraphVisitor

d = dijkstra_shortest_paths(g, [1,5,1,1,1,1],1)#,visitor)

for v in vertices(g)
	println("Vertice: ", v, " parent: ", d.parents[v], " dist from source: ", d.dists[v])
end

println(shortest_path(g, [1,5,1,1,1,1], 1, 6))


# prim_minimum_spantree(g, [1,5,1,1,1,1], 1)


