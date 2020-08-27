"""
    Point

Simple struct representing a 2-D point
"""
struct Point
    x :: Float64
    y :: Float64
end


# s = """
# ..#..
# ..#..
# ##.##
# ..#..
# ..#..
# """

s = """
.#....#####...#..
##...##.#####..##
##...#...#.#####.
..#.....X...###..
..#.#.....#....##
"""

# s = """
# .#....#####...#..
# ##...##.#####..##
# ##...#...#.#####.
# #.#.........###..
# ..#.#...###....##
# ........##......."""


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

# s = """
# .#..#..#..#...#..#...###....##.#....
# .#.........#.#....#...........####.#
# #..##.##.#....#...#.#....#..........
# ......###..#.#...............#.....#
# ......#......#....#..##....##.......
# ....................#..............#
# ..#....##...#.....#..#..........#..#
# ..#.#.....#..#..#..#.#....#.###.##.#
# .........##.#..#.......#.........#..
# .##..#..##....#.#...#.#.####.....#..
# .##....#.#....#.......#......##....#
# ..#...#.#...##......#####..#......#.
# ##..#...#.....#...###..#..........#.
# ......##..#.##..#.....#.......##..#.
# #..##..#..#.....#.#.####........#.#.
# #......#..........###...#..#....##..
# .......#...#....#.##.#..##......#...
# .............##.......#.#.#..#...##.
# ..#..##...#...............#..#......
# ##....#...#.#....#..#.....##..##....
# .#...##...........#..#..............
# .............#....###...#.##....#.#.
# #..#.#..#...#....#.....#............
# ....#.###....##....##...............
# ....#..........#..#..#.......#.#....
# #..#....##.....#............#..#....
# ...##.............#...#.....#..###..
# ...#.......#........###.##..#..##.##
# .#.##.#...##..#.#........#.....#....
# #......#....#......#....###.#.....#.
# ......#.##......#...#.#.##.##...#...
# ..#...#.#........#....#...........#.
# ......#.##..#..#.....#......##..#...
# ..##.........#......#..##.#.#.......
# .#....#..#....###..#....##..........
# ..............#....##...#.####...##."""



"""
    parseString(s)

Parse a string containing . and # into a array holding 0 & 1
"""
function parseString(s)
    s = split(s)
    pos = zeros(5, 17) # zeros(length(s), length(s)) # zeros(6, 17)

    for (row,l) in enumerate(s)
        for (col,e) in enumerate(l)
            if(e == '#')
                pos[row, col] = 1 # this got changed as well!!
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
    rowmax, colmax = size(pos)
    res = Array{Point, 1}()
    for row=1:rowmax
        for col = 1:colmax
            if(pos[row, col] == 1)
               push!(res, Point(row, col))
            end
        end
    end
    res
end

pos = parseString(s)
as = getAsteroids(pos)

# base = Point(14, 12)
base = Point(3, 3)

# idea
# calc angle between y-axis and all asteroids
# sort asteroids by angle AND distance from laser



angles = Dict{Point, Float64}()

for a in as
    angles[a] = atan(a.y - base.y, base.x - a.x) # bloddy trial & error :-(
end

# order the shit by increasing angles
res = sort(collect(angles), by=x->x[2])

# split into sub arrays with negative & positive angles
res_min = filter(x -> x[2] < 0, res)
res_plus = filter(x -> x[2] >= 0, res)

# and stitch it together
fin = [res_plus; res_min]
# println(fin)
# only thing that's missing is the ones in line...

# everything above the base point
ind1=findall(x -> x[1].y==base.y && x[1].x<base.x, fin)

in1 = fin[ind1]
out1 = sort(in1, by=x->x[1].x, rev=true)
fin[ind1] = out1

# everything below the base point
ind2=findall(x -> x[1].y==base.y && x[1].x>base.x, fin)

in2 = fin[ind2]
out2 = sort(in2, by=x->x[1].x)
fin[ind2] = out2


# everything right to the base point
ind3=findall(x -> x[1].x==base.x && x[1].y>base.y, fin)

in3 = fin[ind3]
out3 = sort(in3, by=x->x[1].y)
fin[ind3] = out3


# everything left to the base point
ind4=findall(x -> x[1].x==base.x && x[1].y<base.y, fin)

in4 = fin[ind4]
out4 = sort(in4, by=x->x[1].y, rev=true)
fin[ind4] = out4

# TODO: Unfortunately not done, as we have ordered only points on the same x- & y- axis as the laser
# there could be asteroids on a line from the laser which has an arbitrary angle...

# next idea: throw the points with 2 additional columns, angle & distance into a julia dataframe and sort them via angle AND distance...

println("done")
