# the image has size 25 pxs wide & 6 pxs tall
# one layer requires 25 x 6 = 150 numbers

function readInput()
    f = open("2019_08.txt")
    s = readline(f)
    close(f)
    s
end


function part1(sarray)
    # reshape so that we have all pixels of one layer in one dim, the second dim is the layer
    sarray = reshape(sarray, 150, 100)

    # count the number of zeros along each layer
    numzeros = count(x -> x == 0, sarray, dims=1)

    # get the min of zeros
    (minval, idx) =  findmin(numzeros)
    idx_use = idx.I[2] # ugly hack to get the "real" index

    sollayer = sarray[:,idx_use] # determine the correct layer

    num_1 = count(x -> x==1, sollayer) # count 1's
    num_2 = count(x -> x==2, sollayer) # count 2's

    num_1 * num_2 # calc result....
end

function part2(sarray)
    # reshape so that we have all pixels of one layer in one dim, the second dim is the layer
    sarray = reshape(sarray, 150, 100)

    # sarray[1,:] are the pixels of ONE pos along all layers
    res = zeros(150)

    for k = 1:150
        pxs = sarray[k, :] # collect pixesl of one pos along all layers
        idx = findfirst(x->x!=2, pxs) # the first non-transparent pixel wins
        res[k] = pxs[idx] # and store the pixel value
    end

    res
end

function displayResult(res)    
    # other plotting solution (based on reddit)
    pic0 = map(x -> x == 1 ? '⬛' : '⬜', res)

    for i in 1:6
        println(join(pic0[((i-1)*25 + 1):(i*25)]))
    end
end


s = readInput()
nchars = length(s) # = 15000, therefore we have 15000 / 150 = 100 layers

# convert the line into a list of ints
sarray = parse.(Int, split(s, ""))

# part1(sarray) # -> 1072


res = part2(sarray)
# img = reshape(res, 25, 6) # make an image
# heatmap(img) # and display... doesn't work, cant see letters :-(
displayResult(res)
