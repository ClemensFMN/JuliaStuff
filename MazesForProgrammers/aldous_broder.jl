include("basic.jl")

function AldousBroder(g :: Grid)
    unvisited = g.rows * g.cols - 1
    cell = g.cells[randomCellInd(g)]
    #@show cell
    while(unvisited > 0)
        ngbs = neighbors(cell)
        n = g.cells[rand(ngbs)] # choose a random neighbour to cell
        #@show n
        if(isempty(n.ngbs))
            link(cell, n)
            # @show "link", cell, n
            unvisited = unvisited - 1
        end
        cell = n
        #@show unvisited
    end 
        
end

g = Grid(10,10)
setupGrid(g)
AldousBroder(g)
toPic(g)
