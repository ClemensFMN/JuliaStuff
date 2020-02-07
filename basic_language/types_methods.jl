# define a simple 2-d point and some operations with it

struct Point
    x :: Float64
    y :: Float64
end


function Base.:+(p1::Point, p2::Point) # adding two points
    Point(p1.x + p2.x, p1.y + p2.y)
end


function Base.:*(a::Number, p1::Point) # scalar x Point
    Point(a*p1.x, a*p1.y)
end


function Base.:*(p1::Point, p2::Point) # inner product
    p1.x * p2.x + p1.y * p2.y
end




p1 = Point(3,4)
p2 = Point(5,6)

@show p1 + p2

@show 2 * p1

@show p1*p2
