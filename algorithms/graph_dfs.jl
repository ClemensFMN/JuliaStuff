# using DataStructures

# type holding the different node colors
@enum NodeColor White Grey Black

# we have a DFSData structure which the DFS algorithm fills
mutable struct DFSData
    color :: NodeColor
    d :: Int # time set to grey
    f :: Int # time to black
    parent :: String # parent node
end


function dfs(G)
    # DFS again, this time the DFSData struct is used
    verts = keys(G)
    vertices = Dict{String, DFSData}()
    
    for v in verts # init
        vertices[v] = DFSData(White, 0, 0, "")
    end

    global time = 0 # the global time parameter is super ugly

    # for the purpose of demo, start with s, then t
    #dfs_visit(G, vertices, "s")
    # second demo, start with t
    # dfs_visit(G, vertices, "t")
    # topological sort
    dfs_visit(G, vertices, "A")
    dfs_visit(G, vertices, "C")

#    the correct approach: start with some vertex & choose another one as long as unvicited vertices are there...
#    for u in verts
#        if(vertices[u].color == White)
#            dfs_visit(G, vertices, u, time)
#        end
#    end
    vertices
end


function dfs_visit(G, vertices, u)
    @show u
    global time
    global time = time + 1
    vertices[u].d = time
    vertices[u].color = Grey

    for v in G[u]
        if(vertices[v].color == White) # not visited?
            vertices[v].parent = u
            dfs_visit(G, vertices, v)
        end
    end

    vertices[u].color = Black
    global time = time + 1
    vertices[u].f = time
end


function vertices2Dot(vertices)
    println("digraph BST {")
    for (vert, data) in vertices
        strt = data.parent
        stp = vert
        if(strt != "" && stp != "")
            println("$strt -> $stp;")
        end
        attrs = string(stp, " [label=\"", stp, " (", data.d, ", ", data.f, ")\"]")
        println(attrs)
    end
    println("}")
end

function G2Dot(G)
    println("digraph BST {")
    for (vert, verts) in G
        for v in verts
            println(vert, "->", v, ";")
        end
    end
    println("}")        
end


# the example graph from Cormen et al, Fig. 22.5
#G = Dict([
#    # "s" => ["w", "z"], # option 1
#    "s" => [], # option 2
#    "t" => ["u", "v"],
#    "u" => ["t", "v"],
#    "v" => ["s", "w"],
#    "w" => ["x"],
#    "x" => ["z"],
#    "y" => [],
#    "z" => ["w", "y"]])

#res = dfs(G)
#println(res)


#vertices2Dot(res)

# example for topological sort
G = Dict([
    "A" => ["B"],
    "C" => ["B"],
    "B" => ["D", "E"],
    "E" => ["F"],
    "F" => ["D"],
    "D" => []])

res = dfs(G)
println(res)

