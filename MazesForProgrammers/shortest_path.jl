include("aldous_broder.jl")
using LightGraphs

# we want to solve a maze using Dijkstra's algorithm

# let's create a maze first
g = Grid(50,50)
setupGrid(g)
AldousBroder(g)

# the maze cells are identified via tuples (row, col). For LightGraphs to work, we need to convert them into integers
# next we need to convert our maze 

toInt(c::Cell, g::Grid) = c.col + (c.row - 1) * g.cols

toCell(i, g::Grid) = (convert(Int, ceil(i/g.cols)), 1 + mod(i-1, g.cols))


function createGraph(g)

    # now we create a LightGraph graph
    lg = DiGraph(g.rows * g.cols)


    weight_mtx = zeros(g.rows * g.cols, g.rows * g.cols)

    # go over all cells and add an edge to the graph if there is a connection to one of its neighbours...

    for rowInd = 1:g.rows
        for colInd = 1:g.cols

            currCell = g.cells[(rowInd,colInd)]
            curCellInd = toInt(currCell, g)
            ns = currCell.ngbs

            for n in ns
                nInd = toInt(g.cells[n], g)
                add_edge!(lg, curCellInd, nInd)
                weight_mtx[curCellInd, nInd] = 1.0
            end
        end
    end
    lg, weight_mtx
end

lg, weight_mtx = createGraph(g)
collect(edges(lg))

res = dijkstra_shortest_paths(lg, 1, weight_mtx)
pth = enumerate_paths(res, 2500)

pth = map(x->toCell(x,g), pth)

toPic(g, pth)

