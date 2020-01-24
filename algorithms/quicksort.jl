
# Haskell-inspired version. Split the input list using filter function and recursivly call quicksort again
function quicksort_func(A)
    @show A
    if(length(A) == 0)
        return A
    else
        pivot = A[end]
        left = filter(x -> x <= pivot, A[1:end-1])
        right = filter(x -> x > pivot, A[1:end-1])
        @show left, right
        return [quicksort_func(left) ; [pivot] ; quicksort_func(right)]
    end
end


# taken from https://rosettacode.org/wiki/Sorting_algorithms/Quicksort

function quicksort!(A,i=1,j=length(A))
    if j > i
        pivot = A[rand(i:j)] # random element of A
        left, right = i, j
        while left <= right
            while A[left] < pivot
                left += 1
            end
            while A[right] > pivot
                right -= 1
            end
            if left <= right
                A[left], A[right] = A[right], A[left]
                left += 1
                right -= 1
            end
        end
        quicksort!(A,i,right)
        quicksort!(A,left,j)
    end
    return A
end

# partition function according to Cormen
function partition_cormen(A,p,r)
    x = A[r]
    @show x
    i = p-1
    for j=p:r-1
        @show j
        @show A
        if A[j] <= x
            println("smaller")
            i = i+1
            @show i,j
            A[i], A[j] = A[j], A[i]
        end
    end
    A[i+1], A[r] = A[r], A[i+1]
    return i+1
end

function qsort_cormen(A,p,r)
    if(p < r)
        q = partition_cormen(A,p,r)
        qsort_cormen(A,p,q-1)
        qsort_cormen(A,q+1,r)
    end
end


lst =[2,8,7,1,3,5,6,4]



#res = quicksort!(lst)
#println(res)

#res = quicksort_func(lst)
#println(res)
    
# res = partition_cormen(lst, 1, length(lst))
qsort_cormen(lst,1,length(lst))
lst
