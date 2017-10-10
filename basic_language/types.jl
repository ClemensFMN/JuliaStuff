immutable Point
    x :: Float64
    y :: Float64
end

function dist(p1::Point, p2::Point)
    return((p1.x - p2.x)^2 + (p1.y - p2.y)^2)
end

p1 = Point(2,3)
p2 = Point(4,5)

println(dist(p1, p2))

# some kind of "indicator type"
immutable Id
end

# defining a union
PointOrId = Union{Point, Id}

# some stupid function returning our union type
function f1(x)
    if(x == 0) Id()
    else Point(x,x)
    end
end

println(f1(0))
println(f1(1))

# the function dispatches depending on the type
# methods(f2) says
# # 1 method for generic function "f2":
# f2(x::Union{Id, Point}) in Main at /home/cnovak/src/julia/JuliaStuff/basic_language/types.jl:34
function f2(x::PointOrId)
    if(typeof(x) == Point)
        return(x.x + x.y)
    else
        return "Id"
    end
end


pID = Id()
println(f2(p1))
println(f2(pID))

# here we define a polymorphic function instead...
# methods(f3) yields
# # 2 methods for generic function "f3":
# f3(x::Id) in Main at /home/cnovak/src/julia/JuliaStuff/basic_language/types.jl:48
# f3(x::Point) in Main at /home/cnovak/src/julia/JuliaStuff/basic_language/types.jl:47

f3(x::Point) = x.x + x.y
f3(x::Id) = 0

println(f3(p1))
println(f3(pID))
