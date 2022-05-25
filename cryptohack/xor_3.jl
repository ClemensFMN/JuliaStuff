using IterTools

inp = "73626960647f6b206821204f21254f7d694f7624662065622127234f726927756d"

# getting the key
# the first encrypted char
inp_1 = parse(Int, "73", base = 16)
# shall become a 'c'
cleartext_1 = Int('c')
# and we obtain the key as
key = xor(inp_1, cleartext_1)


res = []

for chunk in partition(inp, 2)
    chk = join(chunk)
    temp = parse(Int, chk, base=16)
    clr = xor(temp, key)
    ch = Char(clr)
    append!(res, ch)
end

println(join(res))
