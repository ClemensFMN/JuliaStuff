# sudoku solver in julia

function parseString(s)
   problem = Dict()
   temp = zip(board, collect(split(s, "")))
   for pos in temp
      val = pos[2]
      if(val == "0")
         val = collect(1:9)
      else
         val = [parse(val)]
      end
      problem[pos[1]] = val
   end
   problem
end

function printBoard(brd)
   for r in rows_cols
      for c in rows_cols
         val = brd[(r,c)]
         for v in val
            @printf("%i", v)
         end
         spacer = " "^(10 - length(val))
         print(spacer)
      end
      println()
   end
end


function constProp(brd)
   res = Dict()
   for pos in board
      ngbVals = Set()
      for n in neighbours[pos]
         if(length(brd[n])==1)
            tmp = brd[n][1]
            push!(ngbVals, tmp)
         end
      end
      res[pos] = setdiff(brd[pos], ngbVals)
      #println("POS", pos, "brd[pos]", brd[pos], "ngbVals", ngbVals, "res[pos]", res[pos])
   end
   res
end

@enum ResultType NotSolvable Solved Ambiguous

function isSolution(brd)
    brdLength = map(x->length(x), values(brd))
    brdOnes = map(x->x==1, brdLength)
    brdZeros = map(x->x==0, brdLength)
    if(all(brdOnes))
        return(Solved)
    elseif(any(brdZeros))
        return(NotSolvable)
    else
        return(Ambiguous)
    end
end


function constPropComplete(brd)
    bnew = brd
    changed = true
    while(changed == true)
        res = constProp(bnew)
        changed = bnew != res
        bnew = res
    end
    (bnew, isSolution(bnew))
end

finished = false
# in order for the function to be able to use finished in an if statement, the
# function needs to declare it as global...
# weird, but that's the way it is according to
# https://stackoverflow.com/questions/24830074/julia-variable-not-defined
function solveIt(brd)
   global finished 
   bnew, solution = constPropComplete(brd)
   result = bnew
   if(finished == false)
      if(solution == Solved)
         println("Found solution")
         printBoard(bnew)
         finished = true
      elseif(solution == NotSolvable)
         println("got stuck")
      else #ambiguous
         for pos in keys(bnew)
            if(length(bnew[pos]) > 1)
               if(!finished)
                  for cand in bnew[pos]
                     temp = bnew
                     temp[pos] = [cand]
                     solveIt(temp)
                  end
               end
            end
         end
      end
   end
end

# some GLOBAL STUFF setting up data structures etc...
rows_cols = collect(1:9)

board = [(r,c) for r in rows_cols for c in rows_cols]

grps = [(1,2,3),(4,5,6),(7,8,9)]

neighbours = Dict()

for board_pos in board
   curr_r = board_pos[1]
   curr_c = board_pos[2]

   ngb_rows = filter(x->x[1]==curr_r, board)
   ngb_cols = filter(x->x[2]==curr_c, board)

   curr_row_grp = 0
   curr_col_grp = 0

    for grp in grps
      if(curr_c in grp)
         curr_col_grp = grp
      end
      if(curr_r in grp)
         curr_row_grp = grp
      end
   end
   #println(curr_row_grp, curr_col_grp)
   
   ngb_grp = [(r,c) for r in curr_row_grp for c in curr_col_grp]
   tempSet = Set([ngb_rows; ngb_cols; ngb_grp])
   delete!(tempSet, board_pos)
   neighbours[board_pos] = tempSet
end


# taken from the article http://norvig.com/sudoku.html
# also the first entry in http://norvig.com/easy50.txt
# this sudoku can be completely solved via constraint propagation...
#brd1 = "003020600900305001001806400008102900700000008006708200002609500800203009005010300"

# slighlty more DOFs -> not solvable via CP alone
brd1 = "000000000900305001001806400008102900700000008006708200002609500800203009005010300"

problem = parseString(brd1)

printBoard(problem)

println()

#res = constPropComplete(problem)
#printBoard(res[1])
#println(res[2])

solveIt(problem)

