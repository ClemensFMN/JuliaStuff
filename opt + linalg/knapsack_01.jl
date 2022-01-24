# solving a 0-1 Knapsack problem
# strongly inspired by the corresponding python program
# julia uses 1-based arrays, but we need to manage values for w = 0 as well -> we use dicts instead (as i'm too stupid and make tons of one-off errors when accessing arrays) 

wvec = [2, 3, 5]
vvec = [3, 5, 7]
W = 5

# taken from Kellerer et al, Knapsack Problems (p. 16)
#wvec = [2, 3, 6, 7, 5, 9, 4]
#vvec = [6, 5, 8, 9, 6, 7, 3]
#W = 9


n = length(wvec)

# this is m[i,w], the maximum value that can be attained with weight < w using only the first i items
m = Dict{Tuple{Int, Int}, Int}()
content = Dict{Tuple{Int, Int}, Vector{Int}}()

# boundary condition m[0,w] = 0
for j in 0:W
    m[(0,j)] = 0
    content[(0,j)] = []
end

for j in 1:n
    m[(j,0)] = 0
    content[(j,0)] = []
end


# special treatment for the first row, m[1,j]
for j in 0:W
    if wvec[1] > j
        # the first item does not yet fit into the bag
        # -> zero total value
        m[(1, j)] = 0
        # and no item
        content[(1, j)] = []

    else
        # the first item fits into the bag -> add it        
        # set total value accordingly        
        m[(1, j)] = vvec[1]
        # and add the first item
        content[(1, j)] = [1]
    end
end


# now we calc m[i,w]
for i in 1:n
    for j in 1:W
        if j >= wvec[i]
            #@show i,j
            # the i-th element would fit in -> there are two options
            # option 1: keep the previous content
            cand1 = m[(i-1, j)]
            # option #2: add this new item
            cand2 = m[(i-1, j-wvec[i])] + vvec[i]


            # do what yields a higher total value
            m[(i, j)] = max(cand1, cand2)
            
            # and update the bag content accordingly
            if(cand1 > cand2)
                # option 1: keep previous content
                temp = content[(i-1, j)]
                content[(i, j)] = copy(temp)
            else
                # option 2: add new item
                temp = content[(i-1, j-wvec[i]+1)]
                content[(i, j)] = copy(temp)
                append!(content[(i, j)], i)
            end
        else
            # i-th element does not fit -> only option 1: keep 
            # previous content
            m[(i, j)] = m[(i-1, j)]
            temp = content[(i-1, j)]
            content[(i, j)] = copy(temp)
        end
    end
end

println("max achievable value = ", m[(n,W)])
println("corresponding knapsack content = ", content[(n,W)])



