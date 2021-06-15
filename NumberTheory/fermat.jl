function fermat_a(n, a)
    a = BigInt(a)
    n = BigInt(n)
    res = rem(a^(n-1), n)
    if(res == 1)
        return true
    else
        return false
    end
end

function fermat(n, k)
    for iter = 1:k
        a = rand(2:n-2)
        res = fermat_a(n, a)
        if(res == false)
            return false
        end
    end
    return true
end



@show fermat_a(221, 38) # -> true (fermat liar)
@show fermat_a(221, 24) # -> false

@show fermat(221, 10)
@show fermat(587, 10)
