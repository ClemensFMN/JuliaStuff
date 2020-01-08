# taken from https://rosettacode.org/wiki/LZW_compression#Julia
# further info https://marknelson.us/posts/2011/11/08/lzw-revisited.html

function dictShowC(dict)
    for (k,v) in dict
        if(v > 256)
            print(k, "->", v, " ")
        end
    end
 end

function dictShowD(dict)
    for (k,v) in dict
        if(k > 256)
            print(k, "->", v, " ")
        end
    end
 end



function compressLZW(decompressed::String)
    dictsize = 256
    dict = Dict{String,Int}(string(Char(i)) => i for i in 0:dictsize) # first we initialize with mappings of i -> Char(i); i.e. string of length 1
    result = Vector{Int}(undef, 0)
    w = ""
    for c in decompressed # run through the string to compress
        @show c
        wc = string(w, c) # concat the observed char to w (w is what we have accumulated so far & is contained in the dictionary)
        @show wc
        if haskey(dict, wc) # does dict contain the current substring
            w = wc # yes, then continue scanning the string to compress
        else # no
            push!(result, dict[w]) # emit symbol based on w
            dict[wc] = dictsize # update the dictionary with wc
            dictsize += 1
            w = string(c) # update w with the last observed char and start anew
        end
        @show w
        @show result
        dictShowC(dict)
    end
    if !isempty(w) push!(result, dict[w]) end # emit last symbol
    return result
end


function decompressLZW(compressed::Vector{Int})
    dictsize = 256
    dict     = Dict{Int,String}(i => string('\0' + i) for i in 0:dictsize)
    result   = IOBuffer()
    w        = string(Char(popfirst!(compressed)))
    write(result, w) # output first symbol
    for k in compressed # run through the remaining symbols
        @show k
        if haskey(dict, k) # is the symbol in the dictionary?
            entry = dict[k] # then output the corresponding dict value
        elseif k == dictsize # this is the special case triggered by string+character+string+character+string
            println(k, "special case")
            entry = string(w, w[1])
        else # otherwise we are screwed
            error("bad compressed k: $k")
        end
        @show entry
        write(result, entry) # outpt whatever we have obtained
        dict[dictsize] = string(w, entry[1]) # update the dict with w + first decoded character
        dictsize += 1
        dictShowD(dict)
        w = entry # update w with what we outputted
        @show w
    end
    return String(take!(result))
end





# original = "ABBABBBABBA"
# original = "TOBEORNOTTOBEORTOBEORNOT"
original="ABABABAC"
compressed = compressLZW(original)

println(compressed)

println("*****************")

decompressed = decompressLZW(compressed)
println(decompressed)
println(decompressed == original)
