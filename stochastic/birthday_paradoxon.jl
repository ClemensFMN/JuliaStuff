# birthday paradoxon
# N people in a room, prob that 2 (or more) have the same birthday?


function bdEventFull(n)
    dates = rand(1:365, n)
    bins=unique(dates)
    # that's the super solution: get a Dict date => count
    # Dict([(i, count(u->u==i) for i in bins])
    # we are interested in the "duplicate structure": How many people share a common birthday date? 
    # we return an array of duplicate counts; eg [2 4] indicates that one date is shared by 2 people and another date is shared by 4 people
    cnt = [count(u->u==i, dates) for i in bins]
    #cnt_dupl = filter(i->i > 1, cnt)
    #return(cnt_dupl)
    # exactely 2 persons with smae birthday
    return(2 in cnt)
end




function bdEvent(n)
    dates = rand(1:365, n)
    # here we are interested in something simple: Are there duplicate birthdays?
    # we do not distinguish whether 2 or more people have birthday on d1 or whether there are multiple groups sharing different birthdays... 
    return(n != length(unique(dates)))
end



N = 20
RUNS = 1_000_000


#prob = sum([bdEvent(N) for _ in 1:RUNS])/RUNS
#println("simulation: ", prob)

# analytical_sol = 1-prod(365-N+1:big(365))/365^big(N)
# println("analytical: ", analytical_sol)

prob2 = sum([bdEventFull(N) for _ in 1:RUNS])/RUNS
println("simulation: ", prob2)

# sometihng is still broken :-(
binomial(big(N),2)*365 * prod(364:-1:364-big(N)+3) / 365^big(N)
