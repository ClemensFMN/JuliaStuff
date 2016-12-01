using LightGraphs

# having a graph (creating a random one), find whether the graph contains at least a triangle 

N = 250
p = 0.25

g=erdos_renyi(N,p)

#g = Graph(5)
#add_edge!(g,1,2)
#add_edge!(g,1,3)
#add_edge!(g,3,5)
#add_edge!(g,1,5)

triangle = 0

# run over all edges
for e in edges(g)
    # println(e)
    # begin and end vertice of the edge
    u = e[1]
    v = e[2]
    # check if there is another path (via any of the vertices) between u and v
    # if yes, then we have found a triangle u-v-g-u
    for vert in vertices(g)
        if(has_edge(g,u,vert) & has_edge(g,v,vert))
          # println(u, "  ", v, "  ", vert)
          triangle += 1
        end
    end
end

# We count the number of triangles three-fold; e.g. the triangle 1-2-3 appears three times as 1-2-3, 2-3-1, 3-1-2
println(triangle / 3)

# that's the analytic result...
t = N*(N-1)*(N-2) / (1*2*3)
println(t*p^3)