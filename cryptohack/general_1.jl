inp = [99, 114, 121, 112, 116, 111, 123, 65, 83, 67, 73, 73, 95, 112, 114, 49, 110, 116, 52, 98, 108, 51, 125]

res = []

for c in inp
    temp = Char(c)
    append!(res, temp)
end

println(join(res))

