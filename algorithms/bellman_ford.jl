mutable struct Vertex
    ID :: Int # vertex id
    d :: Int # upper bound for path length
    parent :: Int # parent
end
# define a "simple" constructor
Vertex(i) = Vertex(i, 1000, -1)

# the graph itself contains a list of vertices and edges
mutable struct Graph
    vertices :: Array{Vertex,1}
    edges :: Array{Tuple{Int64,Int64},1}
end


function findVertex(g::Graph, id::Int)
    # take a graph and id and returns the vertex with id
    # not needed, if G.vertices[n] has id = n
    for n in g.vertices
        if(n.ID == id)
            return n
        end
    end
    error("vertex not found in graph")
 end


function init_single_source(G, s)
    # through the graph creation, all vertices but vertex s have the right attributes
    n = G.vertices[s]
    n.d = 0 # and vertex s gets d = 0
end


function relax(G, u, v, weight_mtx)
    # relax edge (u,v) in graph G with weight matrix weight_mtx
    uu = G.vertices[u] # find the corresponding vertices
    vv = G.vertices[v]
    if(vv.d > uu.d + weight_mtx[u,v]) # make the check if we can relax
        vv.d = uu.d + weight_mtx[u,v] # update the vertex v. Magically, this works (function take parameters by reference?)
        vv.parent = uu.ID
    end
end

function bellman_ford(G, s, weight_mtx)
    # Bellman-For algorithm
    init_single_source(G, s)
    for i = 1:length(G.vertices)-1
        for (u,v) in G.edges
            relax(G, u, v, weight_mtx)
        end
    end

    # check for cycles with negative weight -> raise an error
    for (u,v) in G.edges
        uu = G.vertices[u]
        vv = G.vertices[v]
        if(vv.d > uu.d + weight_mtx[u,v])
            error("graph has cycles with negative weight")
        end
    end
end


# define a graph
G = Graph([Vertex(1), Vertex(2), Vertex(3), Vertex(4), Vertex(5), Vertex(6)], [(1,2), (1,3), (1,4), (2,3), (3,4), (3,5), (3,6), (5,6)])

# and weight matrix
#             1  2  3  4  5  6
weight_mtx = [0  1  3  2  0  0  # 1
              0  0  1  0  0  0  # 2
              0  0  0  2  3  6  # 3
              0  0  0  0  0  0  # 4
              0  0  0  0  0  1  # 5
              0  0  0  0  0  0] # 6



#init_single_source(g, 1)
#relax(G, 1, 4, weight_mtx)

# execute the Bellman Ford algorithm
bellman_ford(G, 1, weight_mtx)
println(G)

# add a cycle with negative weight
G = Graph([Vertex(1), Vertex(2), Vertex(3), Vertex(4), Vertex(5), Vertex(6)], [(1,2), (1,3), (1,4), (2,3), (3,4), (3,5), (3,6), (5,6), (3,1)])

# and weight matrix
#             1  2  3  4  5  6
weight_mtx = [0  1  3  2  0  0  # 1
              0  0  1  0  0  0  # 2
             -4  0  0  2  3  6  # 3
              0  0  0  0  0  0  # 4
              0  0  0  0  0  1  # 5
              0  0  0  0  0  0] # 6



#init_single_source(g, 1)
#relax(G, 1, 4, weight_mtx)

# execute the Bellman Ford algorithm
bellman_ford(G, 1, weight_mtx)
println(G)


# now for fun a graph with a negative weight cycle - requires removing the check for negative weight cycles 
G = Graph([Vertex(1), Vertex(2)], [(1,2), (2,1)])
weight_mtx = [0  3
             -5  0]



bellman_ford(G, 1, weight_mtx)
println(G)