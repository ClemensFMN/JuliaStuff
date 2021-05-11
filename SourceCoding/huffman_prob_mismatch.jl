using Distributions
include("huffman.jl")

frq = Dict(1 => 0.01, 2 => 0.02, 3 => 0.05, 4 => 0.05, 5 => 0.1, 6 => 0.1, 7 => 0.17, 8 => 0.5)

tree = huffmantree(frq)

dct = getencoding(tree, "", Dict{Int, String}())

@show dct
stat = cw_stats(frq, dct)
@show stat
@show entropy(values(frq))


N = 100_000

# right symbol dist
# p = Categorical([0.01, 0.02, 0.05, 0.05, 0.1, 0.1, 0.17, 0.5])

# source has different symbol dist
p = Categorical([0.5, 0.02, 0.05, 0.05, 0.1, 0.1, 0.17, 0.01])
syms = rand(p, N)

len  = 0

for sym in syms
    global len += length(dct[sym])
end

@show len/N
