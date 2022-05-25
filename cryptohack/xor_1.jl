inp = "label"

key = 13

res = []

for c in inp
    cint = Int(c)
    temp = xor(cint, key)
    append!(res, Char(temp))
end

println(join(res))
