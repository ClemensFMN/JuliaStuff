function adj_eqals(xs)
    # check array of digits for 2 adjacent ones 
    eq = false
    for k=1:length(xs)-1
        if(xs[k] == xs[k+1])
            eq = true
        end
    end
    eq
end

function adj_eqals_part2(xs)
    res = Int[]
    for el in xs # for element in xs, 
        push!(res, count(x -> x == el, xs)) # count how often is appears
    end
    any(x -> x == 2, res) # if one element appears exactely twice, it is a valid sequence
end


function incr_seq(xs)
    # check that two adjacent digits are non-decreasing
    incr = true
    for k=1:length(xs)-1
        if(xs[k] < xs[k+1])
            incr = false
        end
    end
    incr
end

function check_number(dgts)
    c1 = adj_eqals_part2(dgts)
    c2 = incr_seq(dgts)
    return c1 && c2
end



num = 3455578

dgts = digits(num)

# println(adj_eqals(dgts))
# println(incr_seq(dgts))
# println(check_number(dgts))

nums = 156218:652527

# part 1
# sum(map(x -> check_number(digits(x)), nums))

# part 2

#@show adj_eqals_part2(reverse(digits(111122)))
#@show adj_eqals_part2(reverse(digits(221111)))


sum(map(x -> check_number(digits(x)), nums)) # -> 1148

