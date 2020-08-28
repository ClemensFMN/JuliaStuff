# Idea is to chose two asteroids
# calculate a line of sight between these two & obtain the integer points on this line (getPoints)
# and check if another asteroid blocks this line of sight; i.e. whether any asteroid lies on the integer points calculated before (isShadowed)
# then we iterate over all asteroids, choosing two, calc line of sight & count if observable

# let's assume we already have an array
#  an asteroid is represented by 1, no asteriod -> 0
pos = [0 1 0 0 1;
       0 0 0 0 0;
       1 1 1 1 1;
       0 0 0 0 1;
       0 0 0 1 1]

xmax, ymax = size(pos)

"""
    Point

Simple struct representing a 2-D point
"""
struct Point
    x :: Float64
    y :: Float64
end

"""
    parseString(s)

Parse a string containing . and # into a array holding 0 & 1
"""
function parseString(s)
    s = split(s)
    pos = zeros(length(s), length(s))
    for (row,l) in enumerate(s)
        for (col,e) in enumerate(l)
            if(e == '#')
                pos[row, col] = 1
            end
        end
    end
    pos
end

"""
    getAsteroids(pos)

Based on input pos, return an array of all asteroid positions. Be careful, we use (row,col) coordinates and start with 1,1 in the upper left corner!

"""
function getAsteroids(pos)
    xmax, ymax = size(pos)
    res = Array{Point, 1}()
    for i=1:xmax
        for j = 1:ymax
            if(pos[i,j] == 1)
               push!(res, Point(i,j))
            end
        end
    end
    res
end

"""
    getPoints(p::Point, q::Point)

Return all integer points between point p & q. Be careful, floating point issues may appear
"""
function getPoints(p::Point, q::Point)
    if(p.x != q.x) # we need to be careful to calcluateb the delta also in cases when p.x = q.x or p.y = q.y
        delta = abs(p.x - q.x)
    else
        delta = abs(p.y - q.y)
    end
    
    ts = 0:1/delta:1
    
    res = [Point((1-t) * p.x + t * q.x,
                 (1-t) * p.y + t * q.y) for t in ts]
    res
end

#println(getPoints(Point(0,1), Point(2,3))) # -> [Point(0.0, 1.0), Point(1.0, 2.0), Point(2.0, 3.0)]
#println(getPoints(Point(0,0), Point(4,0))) # -> [Point(0.0, 0.0), Point(1.0, 0.0), Point(2.0, 0.0), Point(3.0, 0.0), Point(4.0, 0.0)]
#println(getPoints(Point(0,0), Point(0,4))) # -> [Point(0.0, 0.0), Point(0.0, 1.0), Point(0.0, 2.0), Point(0.0, 3.0), Point(0.0, 4.0)]

# so far so good; however there are cases where floating point issues appear...

# getPoints(as[1], as[8])
# 4-element Array{Point,1}:
#  Point(1.0, 2.0)
#  Point(2.0, 3.0)
#  Point(3.0, 4.0)
#  Point(4.0, 5.0)


# julia> getPoints(as[8], as[1])
# 4-element Array{Point,1}:
#  Point(4.0, 5.0)
#  Point(3.0000000000000004, 4.000000000000001)
#  Point(2.0, 3.0)
#  Point(1.0, 2.0)



"""
   Checks whether the line of sight between as[a] and as[b] is obstructed by any other point in the array as
""" 
function isShadowed(a::Integer, b::Integer, as)
    source= as[a]
    dest = as[b]
    all_ind = 1:length(as)
    ind_others = setdiff(all_ind, [a b])
    others = as[ind_others]
    ps = getPoints(source, dest)
    for p in ps
        #if(p in others)
        temp = (p.x .- map(e -> e.x, others)).^2 .+ (p.y .- map(e -> e.y, others)).^2 # we make a "fuzzy" test...
        if(minimum(temp) < 0.0001) # this parameter is actually rather critical; do ot set to a "too high" value!
            return true
        end
    end
    return false
end


# tests for isShadowed
#as = getAsteroids(pos)
#isShadowed(1, 2, as) # -> false
#isShadowed(3, 4, as) # -> false
#isShadowed(3, 5, as) # -> true
#isShadowed(1, 9, as)# -> true

"""
    countObservable(as)

Count how many asteroids are observable. Returns a dict(asteroid point, # of obserable asteroids)
"""
function countObservable(as)
    all_asts = 1:length(as)
    obs = Dict{Point, Int}()
    for i in all_asts
        cnt = 0
        for j in all_asts
            if(i != j)
                res = isShadowed(i, j, as)
                #@show as[i], as[j], res
                if(res == false)
                    cnt += 1
                end
            end
        end
        println(as[i], cnt)
        obs[as[i]] = cnt
    end
    obs
end


# s = """
# ......#.#.
# #..#.#....
# ..#######.
# .#.#.###..
# .#..#.....
# ..#....#.#
# #..#....#.
# .##.#..###
# ##...#..#.
# .#....####"""

# s = """
# #.#...#.#.
# .###....#.
# .#....#...
# ##.#.#.#.#
# ....#.#.#.
# .##..###.#
# ..#...##..
# ..##....##
# ......#...
# .####.###."""

# s = """
# .#..#..###
# ####.###.#
# ....###.#.
# ..###.##.#
# ##.##.#.#.
# ....###..#
# ..#.#..#.#
# #..#.#.###
# .##...##.#
# .....#.#.."""

# s = """
# .#..##.###...#######
# ##.############..##.
# .#.######.########.#
# .###.#######.####.#.
# #####.##.#.##.###.##
# ..#####..#.#########
# ####################
# #.####....###.#.#.##
# ##.#################
# #####.##.###..####..
# ..######..##.#######
# ####.##.####...##..#
# .#####..#.######.###
# ##...#.##########...
# #.##########.#######
# .####.#.###.###.#.##
# ....##.##.###..#####
# .#.#.###########.###
# #.#.#.#####.####.###
# ###.##.####.##.#..##"""

# puzzle input
s = """
.#..#..#..#...#..#...###....##.#....
.#.........#.#....#...........####.#
#..##.##.#....#...#.#....#..........
......###..#.#...............#.....#
......#......#....#..##....##.......
....................#..............#
..#....##...#.....#..#..........#..#
..#.#.....#..#..#..#.#....#.###.##.#
.........##.#..#.......#.........#..
.##..#..##....#.#...#.#.####.....#..
.##....#.#....#.......#......##....#
..#...#.#...##......#####..#......#.
##..#...#.....#...###..#..........#.
......##..#.##..#.....#.......##..#.
#..##..#..#.....#.#.####........#.#.
#......#..........###...#..#....##..
.......#...#....#.##.#..##......#...
.............##.......#.#.#..#...##.
..#..##...#...............#..#......
##....#...#.#....#..#.....##..##....
.#...##...........#..#..............
.............#....###...#.##....#.#.
#..#.#..#...#....#.....#............
....#.###....##....##...............
....#..........#..#..#.......#.#....
#..#....##.....#............#..#....
...##.............#...#.....#..###..
...#.......#........###.##..#..##.##
.#.##.#...##..#.#........#.....#....
#......#....#......#....###.#.....#.
......#.##......#...#.#.##.##...#...
..#...#.#........#....#...........#.
......#.##..#..#.....#......##..#...
..##.........#......#..##.#.#.......
.#....#..#....###..#....##..........
..............#....##...#.####...##."""


pos = parseString(s)
as = getAsteroids(pos)
res = countObservable(as)

println(findmax(res))       
    

########## WASTE

# """
#    line_of_sight(s :: Point, d:: Point)

# Construct a line between source point s & destination point d; returns tuple (k, d)

# """
# function line_of_sight(s :: Point, d :: Point)
#     k = (d.y - s.y) / (d.x - s.x)
#     d = s.y - k*s.x
#     return (k,d)
# end

# """
#    line_point(x, k, d)

# Calculates point (x,y) of a line defined by k and d
# """
# line_point(x, k, d) = return Point(x, x*k+d)

# """
#    all_points(k, d, xs)

# Calculates all points of a line defined by k and d at positions xs (vector of x values)
# """
# all_points(k, d, xs) = map(it -> line_point(it, k, d), xs)



#res = getShadowed(base_point, as, xmax, ymax)

#println(res)

# get all positions
#all_pos = [Point(x,y) for x in 1:xmax for y in 1:ymax]
#all_pos = Set(all_pos)

#observable_asts = setdiff(all_pos, Set(res))


#println(length(observable_asts))

#function getShadowed(a::Point, asteroids, xmax, ymax)
#
#    shadow = Array{Point, 1}() # here we hold all shadowed positions
#
#    for ind = 1:length(asteroids) # go over all other asteroids
#        k, d = line_of_sight(a, asteroids[ind]) # obtain k & d for the asteroid
#        xs = asteroids[ind].x:xmax # obtain the x's "behind"
#        ps = all_points(k, d, xs) # get all points
#        ps = filter(x -> x.y == floor(x.y), ps) # filter for integer positions
#        ps = filter(x -> x.y <= ymax, ps) # filter out points outside ymax
#        append!(shadow, ps) # and store into result
#    end
#
#    # setdiff(Set(shadow), Set(asteroids))
#
#    shadow
#end
