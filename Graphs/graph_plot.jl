using LightGraphs
using GraphPlot

function runMe()
    g = Graph(6)

    add_edge!(g,1,2)
    add_edge!(g,1,3)
    add_edge!(g,1,4)
    add_edge!(g,2,3)
    add_edge!(g,3,4)
    add_edge!(g,3,5)
    add_edge!(g,3,6)
    add_edge!(g,5,6)

    #             1  2  3  4  5  6
    weight_mtx = [0  1  3  2  0  0  # 1
                  0  0  1  0  0  0  # 2
                  0  0  0  2  3  6  # 3
                  0  0  0  0  0  0  # 4
                  0  0  0  0  0  1  # 5
                  0  0  0  0  0  0] # 6
    
    weight_mtx = (weight_mtx + weight_mtx')

    # simple plotting
    # gplothtml(g)
    # plot using vertex labels
    # gplothtml(g, 1:6)
    # number vertices and edges
    # gplothtml(g, nodelabel=1:6, edgelabel=1:8)
    
    # plot graph with numbered vertices & edge weights according to weight_mtx
    gplothtml(g, nodelabel=1:6, edgelabel=convert_uwmtx2vec(weight_mtx))
end
    
function convert_uwmtx2vec(m)
    # this converts a weight matrix of an undirected graph into a vector of non-zero weights
    n,_ = size(m)
    res = []
    for row = 1:n
        for col = row+1:n
            if(m[row, col] != 0)
                push!(res, m[row, col])
            end
        end
    end
    res
end

function plotUndirectedGraph(g, weight_mtx)
    nv, ne = size(g)
    gplothtml(g, nodelabel=1:nv, edgelabel=convert_uwmtx2vec(weight_mtx))
end

function convert_dwmtx2vec(m)
    # this converts a weight matrix of a directed graph into a vector of non-zero weights
    n,_ = size(m)
    res = []
    for row = 1:n
        for col = 1:n
            if(m[row, col] != 0)
                push!(res, m[row, col])
            end
        end
    end
    res
end

function plotDirectedGraph(g, weight_mtx)
    nv, ne = size(g)
    gplothtml(g, nodelabel=1:nv, edgelabel=convert_dwmtx2vec(weight_mtx))
end
