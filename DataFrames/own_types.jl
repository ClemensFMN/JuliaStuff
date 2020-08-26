using DataFrames

struct Point
    x :: Float64
    y :: Float64
end

dist(p::Point) = sqrt(p.x ^2 + p.y^2)
angle(p::Point) = atan(p.y, p.x)

points = [Point(0,0), Point(1,1), Point(3,4), Point(2,2)]

col1 = dist.(points)
col2 = angle.(points)

df = DataFrame(p = points, d = col1, alpha = col2)

# due to choosing the coords, P_2 & P_4 have the same angle but different distance
# let's order by angle first & then by distance
# this means, sort by angle & points with the same angle are sorted by distance
dfs = sort(df, [:alpha, :d])
