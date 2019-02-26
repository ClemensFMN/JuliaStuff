# we have a matrix containing bit labels
# every row contains a label
# out of fun, let's get the indices of all labels which have vlue (0 or 1) at the different positions
# output of the function is a matrix where the i-th row contains the label indices where bit position i equals vlue

function getIndices(lbs, vlue)

   N, b = size(lbs) # get size of label matrix
   ind = zeros(Int, b, 2^(b-1)) # init the index matrix

   for bt = 1:b # go over all bit positions
      pos = 1 # init current position
      for row=1:N # go over all rows
         # @show row, bt, lbs[row, bt]
         if(lbs[row, bt] == vlue) # the label contains value vlue
            ind[bt, pos] = row # -> store it in the index matrix
            pos += 1 # increment position
         end
      end
   end
   return(ind)
end

# some labels
lbs = [0 0 0;
       0 0 1;
       0 1 0;
       0 1 1;
       1 0 0;
       1 0 1;
       1 1 0;
       1 1 1]


println(getIndices(lbs, 0))
println(getIndices(lbs, 1))



