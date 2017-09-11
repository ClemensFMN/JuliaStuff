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
         # println("POS", pos, "BRD[POS]", brd[pos])
         if(length(brd[n])==1)
            tmp = brd[n][1]
            #println(tmp)
            push!(ngbVals, tmp)
         end
      end
      # println("POS", pos, "ngbVals", ngbVals)
      res[pos] = setdiff(brd[pos], ngbVals)
   end
   res
end



rows_cols = collect(1:9)

board = [(r,c) for r in rows_cols for c in rows_cols]

grps = [(1,2,3),(4,5,6),(7,8,9)]

neighbours = Dict()

for board_pos in board
   #board_pos = (4,7)
   curr_r = board_pos[1]
   curr_c = board_pos[2]

   ngb_rows = filter(x->x[1]==curr_r, board)
   ngb_cols = filter(x->x[2]==curr_c, board)

   curr_row_grp = 0
   curr_col_grp = 0

    for grp in grps
      if(curr_c in grp)
         curr_row_grp = grp
      end
      if(curr_r in grp)
         curr_col_grp = grp
      end
   end
   ngb_grp = [(r,c) for r in curr_row_grp for c in curr_col_grp]

   tempSet = Set([ngb_rows; ngb_cols; ngb_grp])
   delete!(tempSet, board_pos)
   neighbours[board_pos] = tempSet
end


# taken from the article http://norvig.com/sudoku.html
# also the first entry in http://norvig.com/easy50.txt
# this sudoku can be completely solved via constraint propagation...
brd1 = "003020600900305001001806400008102900700000008006708200002609500800203009005010300"

# slighlty more DOFs -> not solvable via CP alone
# val brd1 = "000000000900305001001806400008102900700000008006708200002609500800203009005010300"

problem = parseString(brd1)

printBoard(problem)

res = constProp(problem)


println()
printBoard(res)
