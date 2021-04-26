# taken from https://rosettacode.org/wiki/Huffman_coding#Julia

abstract type HuffmanTree end
 
struct HuffmanLeaf <: HuffmanTree
    ch::Int
    freq::Real
end
 
struct HuffmanNode <: HuffmanTree
    freq::Real
    left::HuffmanTree
    right::HuffmanTree
end

function makefreqdict(s::String)
    d = Dict{Char, Real}()
    for c in s
        if !haskey(d, c)
            d[c] = 1
        else
            d[c] += 1
        end
    end
    d
end

function huffmantree(ftable::Dict)
    trees::Vector{HuffmanTree} = [HuffmanLeaf(ch, fq) for (ch, fq) in ftable]
    while length(trees) > 1
        sort!(trees, lt = (x, y) -> x.freq < y.freq, rev = true)
        least = pop!(trees)
        nextleast = pop!(trees)
        push!(trees, HuffmanNode(least.freq + nextleast.freq, least, nextleast))
    end
    trees[1]
end

printencoding(lf::HuffmanLeaf, code) = println(lf.ch == ' ' ? "space" : lf.ch, "\t", lf.freq, "\t", code)

function printencoding(nd::HuffmanNode, code)
    code *= '0'
    printencoding(nd.left, code)
    code = code[1:end-1]
 
    code *= '1'
    printencoding(nd.right, code)
    code = code[1:end-1]
end

function getencoding(lf::HuffmanLeaf, code, dct)
    dct[lf.ch] = code
    dct
end

function getencoding(nd::HuffmanNode, code, dct)
    code *= '0'
    dct = getencoding(nd.left, code, dct)
    code = code[1:end-1]
 
    code *= '1'
    dct = getencoding(nd.right, code, dct)
    code = code[1:end-1]
    dct
end

# get average code length
function avgcl(frq, dct)
    syms = keys(frq)
    avg  = 0
    for sym in syms
        p = frq[sym]
        cd = dct[sym]
        avg += p * length(cd)
    end
    avg
end

entropy(probs) = -sum(probs .* log.(2,probs))

function demo()

    # example 1
    # frq = Dict(1 => 0.08, 2 => 0.1, 3 => 0.12, 4 => 0.25, 5 => 0.45)

    # example 2
    frq = Dict(1 => 0.01, 2 => 0.02, 3 => 0.05, 4 => 0.05, 5 => 0.1, 6 => 0.1, 7 => 0.17, 8 => 0.5)

    tree = huffmantree(frq)

    # txt = printencoding(tree, "")

    dct = getencoding(tree, "", Dict{Int, String}())

    @show dct

    avl = avgcl(frq, dct)
    @show avl
    @show entropy(values(frq))
end

