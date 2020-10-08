using Test

include("shortest_path.jl")

@testset "Cell -> Int and back" begin

c0 = g.cells[(1,1)]
c1 = g.cells[(1,10)]
c2 = g.cells[(2,1)]

@test toInt(c0, g) == 1
@test toInt(c1, g) == 10
@test toInt(c2, g) == 11

@test toCell(1, g) == (1,1)
@test toCell(10, g) == (1,10)
@test toCell(11, g) == (2,1)

end

@testset "Grid -> Graph" begin
g = Grid(10,10)
setupGrid(g)

# the center
c1 = g.cells[(2,2)]
c2 = g.cells[(1,2)]
link(c1, c2) # link to upper cell
c3 = g.cells[(2,3)]
link(c1, c3) # link to right cell

lg, weight_mtx = createGraph(g)

c1Ind = toInt(c1, g)
c2Ind = toInt(c2, g)
c3Ind = toInt(c3, g)

@test has_edge(lg, c1Ind, c2Ind)
@test has_edge(lg, c1Ind, c3Ind)
@test weight_mtx[c1Ind, c2Ind] == 1.0
@test weight_mtx[c1Ind, c3Ind] == 1.0

end

