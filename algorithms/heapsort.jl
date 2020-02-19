mutable struct Heap
    A :: Array{Int,1}
    heapsize :: Int
    size :: Int
end

Heap(A) = Heap(A, length(A), length(A))

function parent(i)
    return convert(Int, floor(i/2))
end

left(i) = 2*i

right(i) = 2*i+1


function dft(h, i)
    # depth-first traversal of the tree starting at node i
    println(h.A[i]) # print "current" node
    if(left(i) <= h.heapsize) # if a left node exists, continue with there
        dft(h, left(i))
    end
    if(right(i) <= h.heapsize) # if a right node exists, continue there
        dft(h, right(i))
    end
end

function toDot(h, i)
    function intern(h,i)
        # take a heap and convert it in a dot-language description. make a png via dot name.dot -Tpng > name.png
        if(left(i) <= h.heapsize) # if a left node exists, continue with there
            println(h.A[i], " -> ", h.A[left(i)], ";")
        end

        if(right(i) <= h.heapsize) # if a right node exists, continue there
            println(h.A[i], " -> ", h.A[right(i)], ";")
        end

        if(left(i) <= h.heapsize) # if a left node exists, continue with there
            intern(h, left(i))
        end

        if(right(i) <= h.heapsize) # if a right node exists, continue there
            intern(h, right(i))
        end
    end
    println("digraph BST {");
    intern(h,i)
    println("}")
end
    
function max_heapify(H, i)
    #@show i
    #toDot(H, 1)
    # Exchanges H.A[i], H.A[left(i)], and H.A[right(i)] so that H.A[i] \geq H.A[left(i)] & H.A[i] \geq H.A[right(i)]
    # Assumes that binary trees rooted at H.A[left(i)] and H.A[right(i)] are max-heaps    
    l = left(i)
    r = right(i)
    if(l <= H.heapsize && H.A[l] > H.A[i]) # H.A[left(i)] exists and is bigger
        largest = l
    else
        largest = i
    end
    if(r <= H.heapsize && H.A[r] > H.A[largest]) # H.A[right(i)] exists and is bigger
        largest = r
    end
    if(largest != i)  # if either left or right node is larger...
        H.A[i], H.A[largest] = H.A[largest], H.A[i] # ... exchange them with the current root
        max_heapify(H, largest) # and continue max-heapifying the subtree
    end
end


function build_max_heap(H)
    # build a max-heap from a heap H
    for i in convert(Int, floor(H.size/2)):-1:1 # start at the leaves of the tree and work upward
        max_heapify(H,i)
        #@show i
        #toDot(H,1)
        
    end
end

function heap_sort(H)
    build_max_heap(H)
    for i=H.size:-1:2
        H.A[1], H.A[i] = H.A[i], H.A[1]
        H.heapsize = H.heapsize - 1
        max_heapify(H,1)
        @show i
        toDot(H,1)
    end
end

# priority queue stuff
function heap_extract_max(H)
    max = H.A[1]
    H.A[1] = H.A[H.heapsize]
    H.heapsize = H.heapsize-1
    max_heapify(H, 1)
    return max
end

function heap_increase_key(H,i,key)
    H.A[i] = key
    while(i>1 && H.A[parent(i)] < H.A[i])
        H.A[i], H.A[parent(i)] = H.A[parent(i)], H.A[i]
        i = parent(i)
    end
end


function heap_insert_key(H, key)
    H.heapsize = H.heapsize + 1
    H.A[H.heapsize] = -10000
    heap_increase_key(H, H.heapsize, key)
end



# h = Heap([16, 4, 10, 14, 7, 9, 3, 2, 8, 1])
# max_heapify(h, 2)

# h = Heap([4,1,3,2,16,9,10,14,8,7])
# toDot(h,1)
# build_max_heap(h)

#h = Heap([16,14,10,8,7,9,3,2,4,1])
#toDot(h,1)
#heap_sort(h)


h = Heap([4,1,3,2,16,9,10,14,8,7])
build_max_heap(h)
toDot(h,1)
println(heap_extract_max(h))
toDot(h,1)

# a bit careful here - we increase H.A[9] (which was previously 1) to 12
heap_increase_key(h, 9, 12)
toDot(h,1)

heap_insert_key(h,100)
toDot(h,1)
