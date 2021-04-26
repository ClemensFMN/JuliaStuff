using Distributions
include("huffman.jl")

function oneRun(N)

    p = Uniform(0,1)

    ps = rand(p, N)
    ps = ps ./ sum(ps)

    frq = Dict(zip(1:N, ps))
    tree = huffmantree(frq)

    dct = getencoding(tree, "", Dict{Int, String}())
    # @show dct

    avl = avgcl(frq, dct)
    # @show avl
    # @show entropy(values(frq))
    (avl, entropy(values(frq)))
end

RUNS = 100
N = 32

avl = zeros(RUNS)
H = zeros(RUNS)

for iter = 1:RUNS
    (avl[iter], H[iter]) = oneRun(N)
end

@show log(2, N)
@show mean(avl)
@show mean(H)
@show mean((avl .- H) ./ H)



