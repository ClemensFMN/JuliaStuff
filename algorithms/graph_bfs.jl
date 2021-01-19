using DataStructures

# type holding the different node colors
@enum NodeColor White Grey Black

function bfs_dict(G, s)
    # breadth-first search of graph G with starting vertex s
    # no fancy data structures; only maps are used
    verts = keys(G)# all vertices
    col = Dict{String, NodeColor}() # color of each vertex
    dist = Dict{String, Int}() # distance from s
    prnt = Dict{String, String}()#  parent node in the created BFS tree
    
    for v in verts # init the data structures
        col[v] = White
        dist[v] = -1
        prnt[v] = ""
    end

    # setup the inital node
    col[s] = Grey
    dist[s] = 0
    prnt[s] = ""

    # enqeue s
    Q = Queue{String}()
    enqueue!(Q, s)

    while(!isempty(Q)) # run as long as the queue is not empty
        u = dequeue!(Q)
        @show u
        for adj in G[u]
            if(col[adj] == White) # node not visited?
                col[adj] = Grey # update color
                dist[adj] = dist[u] + 1 # distance
                prnt[adj] = u # and parent
                enqueue!(Q, adj) # enqueue nodes
            end
        end
        col[u] = Black # we have visited and fully processed all neighbours -> set color = Black
    end
    return(dist, prnt)
end

# in the second implementation, the idea is to have a BFSData structure which the BFS algorithm fills
mutable struct BFSData
    color :: NodeColor
    d :: Int # distance to root node
    parent :: String # parent node
end


function bfs_struct(G, s)
    # BFS again, this time the BFSData struct is used
    verts = keys(G)
    vertices = Dict{String, BFSData}()
    
    for v in verts # init
        vertices[v] = BFSData(White, 1000, "")
    end

    # start @ s
    vertices[s] = BFSData(Grey, 0, "")

    Q = Queue{String}()
    enqueue!(Q, s)

    while(!isempty(Q)) # do while queue is not empty
        println("Q at beginning:", Q)
        u = dequeue!(Q)
        println("visited vertex:", u, " with attributes ", vertices[u])
        for adj in G[u]
            if(vertices[adj].color == White) # not visited?
                vertices[adj].color = Grey
                vertices[adj].d = vertices[u].d + 1
                vertices[adj].parent = u
                enqueue!(Q, adj)
            end
        end
        vertices[u].color = Black
    end
    return vertices
end


function printTree(bfs_tree, s, v)
    # print the vertices along the path (obtained via the bfs procedure) from vertex s to vertex v
    if(s == v)
        println(s)
        return
    elseif(bfs_tree[v].parent == "")
        println("no path")
    else
        printTree(bfs_tree, s, bfs_tree[v].parent)
        println(v)
    end
end

function buildTree(bfs_tree, s, v)
    # store the vertices along the path (obtained via the bfs procedure) from vertex s to vertex v
    function iter(v)
        if(s == v)
            push!(tree, s)
            return
        elseif(bfs_tree[v].parent == "")
            error("No path")
        else
            iter(bfs_tree[v].parent)
            push!(tree, v)
        end
    end

    tree = Vector{String}()
    iter(v)
    return tree
end

    



# the example graph from Cormen et al, Fig. 22.3
G = Dict(["v" => ["r"],
          "r" => ["v", "s"],
          "s" => ["r", "w"],
          "w" => ["s", "x", "t"],
          "t" => ["w", "x", "u"],
          "x" => ["w", "t", "u", "y"],
          "u" => ["t", "x", "y"],
          "y" => ["x", "u"]])


#dist, prnt = bfs_dict(G, "s")
#println(dist)
#println(prnt)

res = bfs_struct(G, "s")
println(res)


println("*************")
printTree(res, "s", "y")


tree1 = buildTree(res, "s", "y")
println(tree1)
