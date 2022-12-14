# birthday paradoxon
# N people in a room, prob that 2 (or more) have the same birthday?

function dBEventFull(M,N)
    dates = rand(1:M, N)
    # dates = [2,10,4,4,2,4]
    bins = unique(dates)
    # that's the super solution: get a Dict date => count
    # Dict([(i, count(u->u==i) for i in bins])
    # we are interested in the "duplicate structure": How many people share a common birthday date? 
    # we return an array of duplicate counts; eg [2 4] indicates that one date is shared by 2 people and another date is shared by 4 people
    cnt = [count(u->u==i, dates) for i in bins]
    return(cnt)
end


# count the number of ONE duplicate of N vaues in Uniform(1,M) 
function bdEventDupl(M, N)
    dates = rand(1:M, N)
    bins = unique(dates)
    cnt = [count(u->u==i, dates) for i in bins]
    # exactely 2 persons with same birthday
    cnt2  = count(i -> i==2, cnt)
    cnt2p = count(i -> i>2, cnt)
    #if((cnt2 == 1) & (cnt2p == 0))
    #    @show dates, cnt, cnt2, cnt2p
    #end
    
    return((cnt2 == 1) & (cnt2p == 0))
end


function bdEventDuplk(M,N,k)
    dates = rand(1:M, N)
    # dates = [1,1,4,4,3,5,6]
    bins = unique(dates)
    cnt = [count(u->u==i, dates) for i in bins]
    # k times 2 persons with same birthday
    cnt2  = count(i -> i==2, cnt)
    cnt2p = count(i -> i>2, cnt)
    #if((cnt2 == k) & (cnt2p == 0))
    #    @show dates, cnt, cnt2, cnt2p
    #end
    
    return((cnt2 == k) & (cnt2p == 0))
end 


# count the number of k elements being equal, all other different of N vaues in Uniform(1,M) 
function bdEventFullk(M, N, k)
    dates = rand(1:M, N)
    # dates = [2, 10, 4, 4, 2, 4, 5, 6]
    # dates = [1,2,3,4,5,6,6,6]
    bins = unique(dates)
    # that's the super solution: get a Dict date => count
    # Dict([(i, count(u->u==i) for i in bins])
    # we are interested in the "duplicate structure": How many people share a common birthday date? 
    # we return an array of duplicate counts; eg [2 4] indicates that one date is shared by 2 people and another date is shared by 4 people
    cnt = [count(u->u==i, dates) for i in bins]
    # exactely k persons with same birthday
    cntk  = count(i -> i==k, cnt)
    cntnk = count(i -> i!=k, cnt)
    #if((cntk == 1) & (cntnk == N-k))
    #    @show dates, cnt, cntk, cntnk
    #end
    
    return((cntk == 1) & (cntnk == N-k))
end



function bdEvent(n)
    dates = rand(1:365, n)
    # here we are interested in something simple: Are there duplicate birthdays?
    # we do not distinguish whether 2 or more people have birthday on d1 or whether there are multiple groups sharing different birthdays... 
    return(n != length(unique(dates)))
end


M = 365
N = 50
k = 4

RUNS = 1_000_000


#prob = sum([bdEvent(N) for _ in 1:RUNS])/RUNS
#println("simulation: ", prob)

# analytical_sol = 1-prod(365-N+1:big(365))/365^big(N)
# println("analytical: ", analytical_sol)

#prob2 = sum([bdEventFull(M, N) for _ in 1:RUNS])/RUNS
#println("simulation: ", prob2)

# that's correct :-)
#binomial(big(N),2)*M * prod(M-1:-1:M-1-big(N)+3) / M^big(N)

probk = sum([bdEventDuplk(M, N, k) for _ in 1:RUNS])/RUNS
println("simulation: ", probk)



#probk = sum([bdEventFullk(M, N, k) for _ in 1:RUNS])/RUNS
#println("simulation: ", probk)

#binomial(big(N),k)*M * prod(M-1:-1:M-big(N)+k) / M^big(N)
