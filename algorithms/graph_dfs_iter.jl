using DataStructures

# type holding the different node colors
@enum NodeColor White Grey Black

# we have a DFSData structure which the DFS algorithm fills
mutable struct DFSData
    color :: NodeColor
    d :: Int # time set to grey
    f :: Int # time to black
    parent :: String # parent node
end


function dfs(G, s)
    # DFS again, this time the DFSData struct is used
    verts = keys(G)
    vertices = Dict{String, DFSData}()
    
    for v in verts # init
        vertices[v] = DFSData(White, 0, 0, "")
    end

    S = Stack{String}()

    push!(S, s)
    while(!isempty(S))
        v = pop!(S)
        if(vertices[v].color == White) # not visited?
            vertices[v].color = Grey
            println(v)
            # any way to store the parent of the currently visited vertex?
            # this does NOT work
            #vertices[v].parent = s
            #s = v
            for t in G[v]
                push!(S, t)
            end
        end
    end
    vertices
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


# the example graph from Cormen et al, Fig. 22.3
G = Dict(["v" => ["r"],
          "r" => ["v", "s"],
          "s" => ["r", "w"],
          "w" => ["s", "x", "t"],
          "t" => ["w", "x", "u"],
          "x" => ["w", "t", "u", "y"],
          "u" => ["t", "x", "y"],
          "y" => ["x", "u"]])


res = dfs(G, "s")
println(res)


#vertices2Dot(res)

# example for topological sort
# G = Dict([
#     "A" => ["B"],
#     "C" => ["B"],
#     "B" => ["D", "E"],
#     "E" => ["F"],
#     "F" => ["D"],
#     "D" => []])

# res = dfs(G)
# println(res)

