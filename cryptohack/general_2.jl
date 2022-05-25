using IterTools


inp = "63727970746f7b596f755f77696c6c5f62655f776f726b696e675f776974685f6865785f737472696e67735f615f6c6f747d"

res = []

for chunk in partition(inp, 2)
    chk = join(chunk)
    temp = parse(Int, chk, base=16)
    ch = Char(temp)
    append!(res, ch)
end

println(join(res))
