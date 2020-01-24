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


function max_heapify(H, i)
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
    end
end

function heap_sort(H)
    build_max_heap(H)
    for i=H.size:-1:2
        H.A[1], H.A[i] = H.A[i], H.A[1]
        H.heapsize = H.heapsize - 1
        max_heapify(H,1)
    end
end



h = Heap([16, 4, 10, 14, 7, 9, 3, 2, 8, 1])




