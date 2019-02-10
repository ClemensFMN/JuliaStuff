# test how arrays are handled: it seems as reference -> when they are changed in the function,
# the array in the calling function is changed as well
function funWithArrays(A)
  tmp = A[2]
  A[2] = A[1]
  A[1] = tmp
  println("in func", A)
end

#A = [1,2]
#funWithArrays(A)
#println("afterwards", A)



# the actual insertion sort function (based on Cormen, Leiserson..., Introduction to Algorithms)
function insertionsort(A)
  i = 0
  for j = 2:length(A)
    key = A[j]
    println(j, key, A)
    # insert A[j] (= key) into the already sorted sequence A[1...j-1]
    i = j - 1
    while(i > 0 && A[i] > key)
      A[i+1] = A[i] # move items > key one to the right (starting at j-1)
      i = i-1
    end # until all items are shifted OR item > key -> stop ...
    A[i+1] = key # ... and insert A[j] at this "free" position
  end
  println(A)
end




A = [5,2,4,6,1,3]
insertionsort(A)




