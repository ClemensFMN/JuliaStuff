# taken from https://rosettacode.org/wiki/LZW_compression#Julia
# further info https://marknelson.us/posts/2011/11/08/lzw-revisited.html

function compressLZW(decompressed::String)
    dictsize = 256
    dict = Dict{String,Int}(string(Char(i)) => i for i in 0:dictsize) # first we initialize with mappings of i -> Char(i); i.e. string of length 1
    result = Vector{Int}(undef, 0)
    w = ""
    for c in decompressed # run through the string to compress
        @show c
        wc = string(w, c) # concat the observed char to w (w is what we have accumulated so far & is contained in the dictionary)
        @show wc
        if haskey(dict, wc) # does to dict contain the "current substring"
            w = wc # yes, then continue scanning the string to compress
        else # no
            push!(result, dict[w]) # emit symbol based on w
            dict[wc] = dictsize # update the dictionary with wc
            dictsize += 1
            w = string(c) # update w with the last observed char and start anew
        end
        @show w
        @show result
        @show dict
    end
    if !isempty(w) push!(result, dict[w]) end # emit last symbol
    return result
end


function decompressLZW(compressed::Vector{Int})
    dictsize = 256
    dict     = Dict{Int,String}(i => string('\0' + i) for i in 0:dictsize)
    result   = IOBuffer()
    w        = string(Char(popfirst!(compressed)))
    write(result, w)
    for k in compressed
        if haskey(dict, k)
            entry = dict[k]
        elseif k == dictsize
            entry = string(w, w[1])
        else
            error("bad compressed k: $k")
        end
        write(result, entry)
        dict[dictsize] = string(w, entry[1])
        dictsize += 1
        w = entry
    end
    return String(take!(result))
end





original = "ABBABBBABBA"
# original = "TOBEORNOTTOBEORTOBEORNOT"
compressed = compressLZW(original)

println(compressed)

decompressed = decompressLZW(compressed)
println(decompressed)
println(decompressed == original)
