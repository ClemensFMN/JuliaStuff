using DataStructures


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
    relaxed = false
    if(vv.d > uu.d + weight_mtx[u,v]) # make the check if we can relax
        vv.d = uu.d + weight_mtx[u,v] # update the vertex v. Magically, this works (function take parameters by reference?)
        vv.parent = uu.ID
        relaxed = true
    end
    return relaxed # give feedback whether we relaxed the edge or not
end


function adjacent_nodes(G, v)
    # returns the vertices being adjacent to vertex v
    edges = filter(e -> first(e) == v.ID, G.edges) # obtain all edges starting at v
    res = map(e -> G.vertices[e[2]], edges) # obtain the vertex at the other 
end

    

function dijkstra(G, strt, weight_mtx)
    init_single_source(G, strt)
    s = Set{Vertex}()
    pq = PriorityQueue{Vertex, Int}()
    for v in G.vertices
        enqueue!(pq, v, v.d)
    end
    # println(pq)

    while(!isempty(pq))
        u = dequeue!(pq)
        #println(u)
        push!(s, u)
        #println(s)
        adj = adjacent_nodes(G, u)

        for v in adj
            res = relax(G, u.ID, v.ID, weight_mtx)
            if(res == true) # when the edge has been relaxed, then... 
                pq[v] = v.d # we need to update the value in the priority queue...
            end
            
        end
        println(pq)
    end
end




# define a graph
G = Graph([Vertex(1), Vertex(2), Vertex(3), Vertex(4), Vertex(5), Vertex(6)], [(1,2), (1,3), (1,4), (2,3), (3,4), (3,5), (3,6), (5,6)])

# and weight matrix
#             1  2  3  4  5  6
weight_mtx = [0  1  3  2  0  0  # 1
              0  0  1  0  0  0  # 2
              0  0  0  2  3  5  # 3
              0  0  0  0  0  0  # 4
              0  0  0  0  0  1  # 5
              0  0  0  0  0  0] # 6


dijkstra(G, 1, weight_mtx)
G
