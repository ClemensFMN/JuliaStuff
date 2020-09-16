using Test

include("basic.jl")


@testset "Cell Linking and Unlinking" begin

c1 = Cell(1,1,nothing, nothing, nothing, nothing)
c2 = Cell(1,2,nothing, nothing, nothing, nothing)
c3 = Cell(1,3,nothing, nothing, nothing, nothing)

@test isLinked(c1, c2) == false
@test isempty(c1.ngbs) == true
link(c1, c2)
@test isLinked(c1, c2) == true
@test (1,2) in c1.ngbs
@test (1,1) in c2.ngbs
@test length(c1.ngbs) == 1 
unlink(c1,c2)
@test isLinked(c1, c2) == false
@test isempty(c1.ngbs) == true


link(c1, c2)
link(c1,c3)
@test isLinked(c1, c3) == true
unlink(c1,c2)
@test isLinked(c1, c3) == true
@test isLinked(c1, c2) == false

end

@testset "Grid Stuff" begin


g = Grid(10,10)
setupGrid(g)
c1 = g.cells[(1,1)]


@test c1.north == nothing
@test c1.west == nothing
@test c1.south == (2,1)
@test c1.east == (1,2)

c2 = g.cells[(1,10)]
@test c2.north == nothing
@test c2.east == nothing
@test c2.west == (1,9)
@test c2.south == (2,10)

end