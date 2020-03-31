# we need a data structure wich manages several sets
# this will hold our forest
# each set contains the vertices of one tree and is identified by 


# frst = Dict{Int, Set{Int}}( 1 => Set([1,2]), 2 => Set([3,4]))
# println(findSet(frst, 1))
# println(findSet(frst, 2))
# println(findSet(frst, 3))
# println(myUnion(frst, 1, 2))
# println(myUnion(frst, 1, 3))


function findSet(frst, elem)
    # return the id of the tree which contains element elem
    for (id, st) in frst
        if elem in st
            return id
        end
    end
end


function myUnion(frst, e1, e2)
    # join two trees
    ind1 = findSet(frst, e1)
    ind2 = findSet(frst, e2)
    if(ind1 == ind2)
        error("not sure if this is allowed??")
    end
          
    frst[ind1] = union(frst[ind1], frst[ind2]) # one of the trees holds the union
    delete!(frst, ind2) # delete the other entry - otherwise the different sets are no longer disjoint
    return frst
end


function initForest(G)
    # create the initial forest - #vertices disjoint sets each holding one vertex
    vrtcs = Set{Int}() # set of vertices
    for edge in keys(G) # run over all edges, extract vertices and add to vrtcs set
        push!(vrtcs, edge[1])
        push!(vrtcs, edge[2])
    end

    frst = Dict{Int, Set{Int}}() # init empty forest
    for (ind, vertex) in enumerate(vrtcs) # for every vertex create an one-element set with some arbitrary index
        frst[ind] = Set(vertex)
    end
    return frst
end



function kruskalAlg(G, frst)
    # Kruskal Algorithm for obtaining an MST
    A = Set{Tuple{Int, Int}}() # the edge list which will hold the MST
    # some magic to iterate over the dict in order of increasing weights
    # sort converts the dict t an array which we then can sort
    for el in sort(collect(G), by = tuple -> last(tuple))
        edge = el[1]
        @show edge
        u = edge[1]
        v = edge[2]
        if(findSet(frst, u) != findSet(frst, v)) # check if the two edges belong to disjoint trees
            frst = myUnion(frst, u, v) # yes, then merge trees...
            push!(A, (u,v)) # ... and add the edge to the MST
            @show A
        end
    end
    return A
end




# our graph
# take 1 - most simple one
#G = Dict{Tuple{Int, Int}, Real}((1,3) => .10,
#                           (2,3) => 2,
#                           (3,4) => 3,
#                           (1,2) => 1)

G = Dict{Tuple{Int, Int}, Real}((1,2) => 2,
                                (1,3) => 4,
                                (1,4) => 5,
                                (2,3) => 3,
                                (2,4) => 8,
                                (3,4) => 10,
                                (4,5) => 7)

frst = initForest(G)

kruskalAlg(G, frst)





