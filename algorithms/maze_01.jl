using DataStructures

# type holding the different node colors
@enum NodeColor White Grey Black

mutable struct Vertex
    ID :: Int
    parent :: Int
    color :: NodeColor
    dist :: Int
    ngbs :: Array{Int, 1}
end

# define a "simple" constructor
Vertex(i) = Vertex(i, -1, White, 0, [])

mutable struct Graph
    vertices :: Array{Vertex, 1}
    edges :: Array{Tuple{Int, Int},1}
end


function init(g :: Graph)
    # setup color for each node and fill neighbour array
    for v in G.vertices
        v.parent = -1
        v.color = White
        # build up the neighbour array for each vertex
        for e in g.edges
            if(e[1] == v.ID) # does the edge start at the current vertex?
                push!(v.ngbs, e[2]) # -> add the other vertex to the neighbour array
            end
        end
    end
end


function bfs(g :: Graph, u :: Int)
    # actual bfs algorithm
    Q = Queue{Int}()
    enqueue!(Q, u)

    while(!isempty(Q)) # run as long as the queue is not empty
        u = dequeue!(Q)
        for adj in g.vertices[u].ngbs
            if(g.vertices[adj].color == White)
                g.vertices[adj].color = Grey
                g.vertices[adj].parent = u
                g.vertices[adj].dist = g.vertices[u].dist + 1
                enqueue!(Q, G.vertices[adj].ID)
            end
        end
        g.vertices[u].color = Black
    end
end


function buildPath(G, s, t)
    # build the path between vertex s and t as obtained by the BFS algorithm
    function iter(v)
        if(s == v)
            push!(path, s)
            return
        elseif(G.vertices[v].parent == -1)
            error("No path")
        else
            iter(G.vertices[v].parent)
            push!(path, v)
        end
    end

    path = Vector{Int}()
    iter(t)
    return path
end


function buildTree(G)
    # create a list of edges along the tree the bfs algorithm has created
    edges = Vector{Pair{Int, Int}}()
    for u in G.vertices
        for v in G.vertices
            p = G.vertices[v.ID].parent
            if(u.ID in p)
                push!(edges, Pair(u.ID, v.ID))
            end
        end
    end
    edges
end


function printMaze(G, w, h)
    # Print the Maze
    # draw top line
    for j=1:w
        print("+---")
    end
    print("+\n")
    
    for i=1:h # row
        print("|")
        for j=1:w-1 # col
            # @show (i-1)*h + j, (i-1)*h + j + 1
            u = (i-1)*h + j
            v = (i-1)*h + j + 1
            if((u,v) in G.edges)
                print("    ")
            else
                print("   |")
            end
        end
        print("   |\n")

        for j=1:w # col
            #@show (i-1)*h + j, i*h + j
            u = (i-1)*h + j
            v = i*h + j
            if((u,v) in G.edges)
                print("+   ")
            else
                print("+---")
            end
        end
        print("+\n")
    end
end




# define a "classical" graph for BFS
#G = Graph([Vertex(1),Vertex(2),Vertex(3),Vertex(4),Vertex(5),Vertex(6)], [(1,2), (1,3), (1,4), (2,3), (3,4), (3,5), (3,6), (5,6)])


#init(G)
#bfs(G, 1)
#buildPath(G, 1, 6)
#buildTree(G)


# define a graph representing a maze = a tree
v = [Vertex(i) for i in 1:16]

# the graph is bidirectional
#G = Graph(v, [(1,2), (2,3), (3,4), (1,5), (5,6), (6,7), (7,8), (7,11), (11,12), (11,10), (10,9), (9,13), (13,14), (14,15), (15,16),
#              (2,1), (3,2), (4,3), (5,1), (6,5), (7,6), (8,7), (11,7), (12,11), (10,11), (9,10), (13,9), (14,13), (15,14), (16,15)])

# a bit more interesting to draw on screen
G = Graph(v, [(1,2), (1,5), (5,6), (6,7), (7,11), (11,12), (11,10), (10,9), (9,13), (13,14), (14,15), (15,16),
              (2,1), (5,1), (6,5), (7,6), (11,7), (12,11), (10,11), (9,10), (13,9), (14,13), (15,14), (16,15)])


init(G)
bfs(G,1)
buildPath(G, 1, 16)

printMaze(G, 4, 4)
