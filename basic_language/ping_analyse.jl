using StatsBase

s = open("test.txt")
res = readlines(s)
times = parse.(Float64, res)

summarystats(times)



