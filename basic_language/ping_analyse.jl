using StatsBase

s = open("ping_result.txt")
res = readlines(s)
times = parse.(Float64, res)

summarystats(times)



