# Based on the book Mazes for Programmers
# the interesting part (apart from the mazes of course ;-)) is how the OOP Ruby code translates into Julia...
using Luxor

# our cell structure
mutable struct Cell
    row :: Int
    col :: Int
    north :: Union{Tuple{Int, Int}, Nothing}
    east :: Union{Tuple{Int, Int}, Nothing}
    south :: Union{Tuple{Int, Int}, Nothing}
    west :: Union{Tuple{Int, Int}, Nothing}
    # ngbs :: Dict{Cell,Bool}
    # let's try this...
    ngbs :: Array{Tuple{Int, Int}, 1}
end


Cell(row, col, north, east, south, west) = Cell(row, col, north, east, south, west, Array{Tuple{Int, Int}, 1}())
Cell(row, col) = Cell(row, col, nothing, nothing, nothing, nothing, Array{Tuple{Int, Int}, 1}())


"""
    neighbors(c ::Cell)

Returns the neighbors of a cell c considering the boundaries.
"""
function neighbors(c :: Cell)
    res = Array{Tuple{Int, Int},1}()
    if(c.north != nothing)
        push!(res, c.north)
    end
    if(c.east != nothing)
        push!(res, c.east)
    end
    if(c.south != nothing)
        push!(res, c.south)
    end
    if(c.west != nothing)
        push!(res, c.west)
    end
    res
end
   

"""
    link(c1 :: Cell, c2 :: Cell, bidi = true)

Links cell c1 with c2. If bidi = true, links c2 to c1 as well
"""
function link(c1 :: Cell, c2 :: Cell, bidi = true)
    ngb = (c2.row, c2.col)
    push!(c1.ngbs, ngb)
    if(bidi)
        link(c2, c1, false)
    end
end

"""
    unlink(c1 :: Cell, c2 :: Cell, bidi = true)

Unlink cell c and cell c2.
"""
function unlink(c1 :: Cell, c2 :: Cell, bidi = true)
    ngb = (c2.row, c2.col)
    ind = findfirst(x -> x == ngb, c1.ngbs)
    deleteat!(c1.ngbs, ind)
    if(bidi)
        unlink(c2, c1, false) # false to prevent an endless loop!!
    end
end

function isLinked(c1 :: Cell, c2 :: Cell)
    ngb = (c2.row, c2.col)
    ngb in c1.ngbs
end



# ===============================================

# our structure holding the grid
mutable struct Grid
    rows :: Int
    cols :: Int
    cells :: Dict{Tuple{Int, Int}, Cell}
end

Grid(rows, cols) = Grid(rows, cols, Dict{Tuple{Int, Int}, Cell}())

"""
    setupGrid(g :: Grid)

Setup a grid: Create cells and add to grid g, populate N/E/S/W attributes of each cell (considering boundaries)
"""
function setupGrid(g :: Grid)
    for i = 1:g.rows
        for j = 1:g.cols
            c = Cell(i, j)
            g.cells[(i, j)] = c
        end
    end

    for i = 1:g.rows
        for j = 1:g.cols
            c = g.cells[(i,j)]
            c.north = getCellInd(g, i-1, j)
            c.east = getCellInd(g, i, j+1)
            c.south = getCellInd(g, i+1, j)
            c.west = getCellInd(g, i, j-1)
        end
    end
end

"""
    getCellInd(g :: Grid, row :: Int, col :: Int)

Takes row/col values and a grid and applies boundary conditions: If row/col is outside the grid, returns nothing.
"""
function getCellInd(g :: Grid, row :: Int, col :: Int)
    if((1 <= row <= g.rows) && (1 <= col <= g.cols))
        return (row, col)
    else
        return nothing
    end
end

"""
    randomCellInd(g :: Grid)

Returns a random **cell index** of a grid.
"""
function randomCellInd(g :: Grid)
    row = rand(1:g.rows)
    col = rand(1:g.cols)
    (row, col)
end


function toAscii(g :: Grid)
    # TODO
end

"""
    toPic(g :: Grid, cell_size = 50, show = true)

Draws a grid as png. 
"""
function toPic(g :: Grid, pth = [], cell_size = 50, show = true)
    img_w = g.cols * cell_size
    img_h = g.rows * cell_size
    Drawing(img_w+5, img_h+5, "maze.png")
    background("white")
    sethue("black")

    # for cell in values(g.cells)
    for i = 1:g.rows
        for j = 1:g.cols
            cell = g.cells[(i,j)]

            # @show cell
            x1 = (cell.col-1) * cell_size
            y1 = (cell.row-1) * cell_size
            x2 = cell.col * cell_size
            y2 = cell.row * cell_size

            if(cell.north == nothing) # we are the northern border
                line(Point(x1, y1), Point(x2, y1), :stroke) # -> let's draw a line on the northern border
            end
            if(cell.west == nothing) # we are at the western border
                line(Point(x1, y1), Point(x1, y2), :stroke) # -> let's draw a line on the western border
            end

            text(string(i, ",", j), Point(x1 + cell_size/2, y1 + cell_size/2))

            if(cell.east != nothing) # is there another cell in the east?
                cell_east = g.cells[cell.east]
                if(!isLinked(cell, cell_east)) # is the cell in the east linked?
                    line(Point(x2, y1), Point(x2, y2), :stroke) # no link -> let's draw a line
                end
            end
            if(cell.south != nothing) # is there another cell in the south?
                cell_south = g.cells[cell.south]
                if(!isLinked(cell, cell_south)) # is the cell in the south linked?
                    line(Point(x1, y2), Point(x2, y2), :stroke) # no link -> let's draw a line
                end
            end
        end
    end
    # draw lines in the north & on the right 
    line(Point(img_w,0), Point(img_w,img_h), :stroke)
    line(Point(0,img_h), Point(img_w,img_h), :stroke)

    if(!isempty(pth))
        sethue("red")
        for ind = 1:length(pth)-1
            strt = pth[ind]
            stp = pth[ind+1]
            # @show strt, stp
            p1 = Point(cell_size/2 + (strt[2]-1)*cell_size, cell_size/2 + (strt[1]-1)*cell_size)
            p2 = Point(cell_size/2 + (stp[2]-1)*cell_size, cell_size/2 + (stp[1]-1)*cell_size)
            line(p1, p2, :stroke)
        end
    end




    finish()
    if(show)
        preview()
    end               
end
