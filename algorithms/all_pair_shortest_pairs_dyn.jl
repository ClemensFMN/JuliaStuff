


function extend_one(W, L, Pi)
    n = first(size(W))
    Lnew = zeros(n,n)
    Pinew = zeros(Int,n,n)

    for i = 1:n
       for j = 1:n
           # @show i,j
           Lnew[i,j] = Inf
           Pinew[i,j] = Pi[i,j] # safety hatch in case we do not update the path i-j 
	   for k = 1:n
	       # @show k
               # that's the original expression from the book; however, it does not keep track which "path in the min" we take
               #Lnew[i,j] = min(Lnew[i,j], L[i,k] + W[k,j])
               # so we "unroll" the min expression to keep track how we update Lnew
               if(L[i,k] + W[k,j] < Lnew[i,j])
                   Lnew[i,j] = L[i,k] + W[k,j]
                   # println("update pinew")
                   Pinew[i,j] = k
               end
	   end
       end
    end
    Lnew, Pinew
end


function all_pairs_shortest_paths(W)
    n = first(size(W))
    Lnew = W
    Pi = -1*ones(Int, n,n)
    for i = 1:n
        for j = 1:n
            if(W[i,j] != Inf)
                Pi[i,j] = i
            end
        end
    end
    @show Pi
    for m = 2:n-1
       Lnew, Pi = extend_one(W, Lnew, Pi)
    end
    Lnew, Pi
end


function print_shortest_path(i,j,Pi)
    if(i == j)
        println(i)
    elseif(Pi[i,j] == -1)
        error("no path")
    else
        print_shortest_path(i,Pi[i,j],Pi)
        println(j)
    end
end




#L = [ 0  Inf  Inf  Inf  Inf;
#    Inf    0  Inf  Inf  Inf;
#    Inf  Inf    0  Inf  Inf;
#    Inf  Inf  Inf    0  Inf;
#    Inf  Inf  Inf  Inf    0]

W = [   0     3     8   Inf      -4;
      Inf     0   Inf     1       7;
      Inf     4     0   Inf     Inf;
        2   Inf    -5    0      Inf;
      Inf   Inf   Inf    6        0]

#L = [0   Inf  Inf;
#     Inf   0  Inf;
#     Inf Inf   0]

#W = [0     3   1;
#     Inf   0 Inf;
#     Inf   1   0]

# taken from the solution manual
# pi[i,j] = i if there is an edge from i to j, -1 otherwise
#Pi = [-1 1 1;
#      -1 -1 -1;
#      -1 3 -1]


# one step
#L1, Pi1 = extend_one(W, L, Pi)

# one more step
#L2, Pi2 = extend_one(W, L1, Pi1)

Lfinal, Pifinal = all_pairs_shortest_paths(W)



# Lfinal, Pifinal = all_pairs_shortest_paths(W)
