# return true if xs contains x; return false otherwise
function find_1(xs, x)
    for e in xs
        if e == x
            return true
        end
    end
    return false
end

# return true if pred returns true for one element of xs; otherwise return false 
function find_p(xs, pred)
    for e in xs
        if pred(e)
            return true
        end
    end
    return false
end

# return first index of xs for which pred returns true
function find_p_ind(xs,pred)
    for (ind,e) in enumerate(xs)
        if pred(e)
            return ind
        end
    end
    return []
end

# return all indices for which pred returns true
function find_p_inds(xs,pred)
    inds = [ind for (ind, e) in enumerate(xs) if pred(e)]
    return inds
end


lst = [1,2,3,3,4,1,2,10]

println(lst)

println(find_1(lst, 1))
println(find_1(lst, -1))

println(find_p(lst, x -> x==3))
println(find_p(lst, x -> x<-3))

println(find_p_ind(lst, x -> x==3))
println(find_p_ind(lst, x -> x<-3))

println(find_p_inds(lst, x -> x==3))
println(find_p_inds(lst, x -> x<-3))
println(find_p_inds(lst, x -> x%2 == 0))
