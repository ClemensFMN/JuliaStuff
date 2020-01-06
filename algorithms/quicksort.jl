
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

lst =[5, 6, 1, 7, 3, 2, 4, 9, 8]

#res = quicksort!(lst)
#println(res)

res = quicksort_func(lst)
println(res)
    
