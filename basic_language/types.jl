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
