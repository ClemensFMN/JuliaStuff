using IterTools

inp = 11515195063862318899931685488813747395775516287289682636499965282714637259206269
inp_h = string(inp, base=16)

res = []

for chunk in partition(inp_h, 2)
    chk = join(chunk)
    temp = parse(Int, chk, base=16)
    ch = Char(temp)
    append!(res, ch)
end

println(join(res))
