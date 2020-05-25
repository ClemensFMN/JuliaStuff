function initPi(W)
    n = first(size(W))

    Pi = -1*ones(Int, n,n)
    for i = 1:n
        for j = 1:n
            if(W[i,j] != Inf)
                Pi[i,j] = i
            end
            if(i == j)
                Pi[i,j] = -1
            end
        end
    end
    Pi
end



function fw(W)
    n = first(size(W))
    D = W
    Pi = initPi(W)

    for k = 1:n
        Dnew = zeros(n,n)
        Pinew = zeros(Int, n,n)

        for i = 1:n
            for j = 1:n
                if(D[i,j] <= D[i,k] + D[k,j])
                    Dnew[i,j] = D[i,j]
                    Pinew[i,j] = Pi[i,j]
                else
                    Dnew[i,j] = D[i,k] + D[k,j]
                    Pinew[i,j] = Pi[k,j]
                end
	    end
        end
        D = copy(Dnew)
        Pi = copy(Pinew)
    end
    D, Pi
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

Dfinal, Pifinal = fw(W)
