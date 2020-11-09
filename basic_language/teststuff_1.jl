using Test

f1(a, b) = a+b

@testset "Testing f1" begin
    @test f1(3,4) == 7
    @test f1(-3,4) == 1
end

k = 2
f2(a) = k*a

@testset "Testing f2 with a closure" begin
    @test f2(3) == 6
end

# something a bit more complex (taken from AoC/2019_10_part2.jl)
struct Point
    x :: Float64
    y :: Float64
end

base = Point(4, 9)

function myangle(p::Point)
    temp = atan(p.y - base.y, base.x - p.x) # bloddy trial & error :-(
    if(temp < 0.0) # yes -> the asteroid is left from the base point
        temp += 2*pi # for simpler ordering, we add 2pi to the angle so that these angles are positive (> pi)
    end
    temp
end

@testset "myangle" begin
    @testset "base = Point(4, 9)" begin
        @test myangle(Point(1,9)) ≈ 0.0
        @test myangle(Point(4,15)) ≈ pi/2
        @test myangle(Point(8,9)) ≈ pi
        @test myangle(Point(4,3)) ≈ 3*pi/2
    end
end

    
