#using DataFrames
#using DataFramesMeta

using DataStructures

"""
    Point

Simple struct representing a 2-D point
"""
struct Point
    x :: Float64
    y :: Float64
end


# s = """
# .#....#####...#..
# ##...##.#####..##
# ##...#...#.#####.
# ..#.........###..
# ..#.#.....#....##
# """




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
# ##...#.####.#####... 
# #.##########.#######
# .####.#.###.###.#.##
# ....##.##.###..#####
# .#.#.###########.###
# #.#.#.#####.####.###
# ###.##.####.##.#..##"""

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



"""
    parseString(s)

Parse a string containing . and # into a array holding 0 & 1
"""
function parseString(s)
    s = split(s)
    pos = zeros(length(s), length(s)) # zeros(5, 17) # 

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

# base = Point(4, 9)
# base = Point(14, 12)
base = Point(23, 18)

# idea
# calc angle between y-axis and all asteroids
# sort asteroids by angle AND distance from laser
# TODO latest idea is to use a DataFrame with 4 columns:
# Point, angle & distance from basepoint, status ("there" / "destroyed")
# then we sort along angle & dist
# we need to iterate across the result as follows
# 1 take element with smallest angle, smallest distance & mark as "destroyed"
# 2 chose element with second smallest angle & mark as 


function myangle(p::Point)
    temp = atan(p.y - base.y, base.x - p.x) # bloddy trial & error :-(
    if(temp < 0.0) # yes -> the asteroid is left from the base point
        temp += 2*pi # for simpler ordering, we add 2pi to the angle so that these angles are positive (> pi)
    end
    temp
end

# julia> myangle(Point(1,9)) -> 0.0
# julia> myangle(Point(4,15)) -> 1.5707963267948966
# julia> myangle(Point(8,9)) - 3.141592653589793
# julia> myangle(Point(4,3)) -> 4.71238898038469



dist(p::Point) = (p.x - base.x)^2 + (p.y - base.y)^2

# at the end of the day, we want a dict mapping angles to arrays of points. the array will hold all points having the same angle and is ordered by decreasing distance
# angle => [Point(1,2), Point(2,4)]
as_dic = Dict{Float64, Array{Point,1}}()

# go over all asteroids
for a in as
    ang = myangle(a)
    temp = get(as_dic, ang, [])
    push!(temp, a) # and add the current asteroid to the list of asteroids already associated with this angle
    as_dic[myangle(a)] = temp
end


for a in keys(as_dic)
    ps = as_dic[a]
    #@show ps, dist.(ps)
    sort!(ps, by=(e -> dist(e)), rev=true) # we sort the list for a specific angle by distance from base point
    #@show ps, dist.(ps)
    as_dic[a] = ps
end


ks = keys(as_dic)
as_fin = sort(collect(as_dic), by=x->x[1]) # that's the array of pairs we want to work on (angle, Array{Point})


# go over the circle one round, pop the asteroid from each list (that's the one being closest to the base point)
function one_round(as_fin)
    result = Array{Point, 1}()
    for (ind,a) in enumerate(as_fin)
        tmp = a[2]
        if(!isempty(tmp))
            p = pop!(tmp)
            # @show p
            push!(result, p)
        end
        #if(isempty(tmp)) # it does not seem to be allowed to change the array while iterating over it... so we leave the array intact but need to ensure that we only pop when the array is non-empty...
        #    popat!(as_fin, ind)
        #end
    end
    result
end

function shootthemall(as_fin)
    result = Array{Point, 1}()

    # while(!isempty(as_fin)) # go on with rotating as long there are points there... 
    for i = 1:5
        tmp = one_round(as_fin) # one round of shooting
        append!(result, tmp) # store the result
        as_fin = filter(x -> !isempty(x[2]), as_fin) # now we 
#        println("*********************")
#        @show i
#        @show as_fin
    end
    result
end


res = shootthemall(as_fin)




# WASTEPAPER BASKET

# df = DataFrame(id = 1:length(as), as = as, angle = myangle.(as), dist=dist.(as), destroyed = false, order = 0)

# # dfs = sort(df, [:angle, :dist])

# # now we need to iterate across the rows
# # start with the smallest angle & closest point -> mark as destroyed
# # increase the angle & search for closest point which is not destroyed -> mark as destroyed

# function shootorder(df)

#     cnt  = 1
#     res = @linq df |> orderby(:dist) |> orderby(:angle)
#     ht = res[1,:]
#     df[ht.id, :destroyed] = true
#     df[ht.id, :order] = cnt
    
#     current_angle = df[ht.id, :angle]

#     for k = 1:34
#         cnt += 1
#         # close. however, we run into an issue when the last query part does NOT produce any result.
#         # this happens when we have finished Point(1,8). now there is no point with :angle > current_angle
#         res = @linq df |> orderby(:dist) |> orderby(:angle) |> where(:destroyed .== false) |> where(:angle .> current_angle) 
#         @show k, res
#         ht = res[1,:]
#         df[ht.id, :destroyed] = true
#         df[ht.id, :order] = cnt
#         current_angle = df[ht.id, :angle]
#         # @show k, df
#     end
# #df
# end


# # another idea
# # sort by angle, group by angle
# function shootorder2(df)
#     asordered = Array{Point, 1}()
    
#     res = @linq df |> orderby(:dist) |> orderby(:angle) |> groupby(:angle)
#     for k = 1:length(res)
#         tmp = res[k]
#         len,_ = size(tmp)
#         if(len > 0)
#             as = tmp[1,:]
#             @show as
#             push!(asordered, as.as)
#             res[k] = tmp[2:len-1,:] # this does NOT work
#         end
#     end
#     asordered
# end


#angles = Dict{Point, Float64}()
#
#for a in as
#    angles[a] = atan(a.y - base.y, base.x - a.x) # bloddy trial & error :-(
#end

#ind = findall(e->e<0, angles)

# order the shit by increasing angles
#res = sort(collect(angles), by=x->x[2])

# split into sub arrays with negative & positive angles
#res_min = filter(x -> x[2] < 0, res)
#res_plus = filter(x -> x[2] >= 0, res)

# and stitch it together
#fin = [res_plus; res_min]
# println(fin)

# only thing that's missing is the ones in line...

# everything above the base point
# ind1=findall(x -> x[1].y==base.y && x[1].x<base.x, fin)

# in1 = fin[ind1]
# out1 = sort(in1, by=x->x[1].x, rev=true)
# fin[ind1] = out1

# # everything below the base point
# ind2=findall(x -> x[1].y==base.y && x[1].x>base.x, fin)

# in2 = fin[ind2]
# out2 = sort(in2, by=x->x[1].x)
# fin[ind2] = out2


# # everything right to the base point
# ind3=findall(x -> x[1].x==base.x && x[1].y>base.y, fin)

# in3 = fin[ind3]
# out3 = sort(in3, by=x->x[1].y)
# fin[ind3] = out3


# # everything left to the base point
# ind4=findall(x -> x[1].x==base.x && x[1].y<base.y, fin)

# in4 = fin[ind4]
# out4 = sort(in4, by=x->x[1].y, rev=true)
# fin[ind4] = out4

# # TODO: Unfortunately not done, as we have ordered only points on the same x- & y- axis as the laser
# # there could be asteroids on a line from the laser which has an arbitrary angle...

# # next idea: throw the points with 2 additional columns, angle & distance into a julia dataframe and sort them via angle AND distance...

# println("done")
