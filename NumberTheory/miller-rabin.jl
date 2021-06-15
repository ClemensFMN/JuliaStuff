# miller-rabin test

# rewrite n = 2^s*d + 1
function rewrite(n)
    nm1 = n-1
    for s = 1:convert(Int, floor(log(2,nm1)))
        dcand = nm1 / 2^s
        # @show s, dcand
        if(isinteger(dcand))
            dcand = convert(Int, dcand)
            if(isodd(dcand))
                return(dcand, s)
            end
        end
    end
end

function miller_rabin_a(n, a)
    a = BigInt(a)
    d, s = rewrite(n)
    d = BigInt(d)
    #@show d, s
    x = mod(a^d, n)
    #@show x
    if((x == 1) || (x == n-1))
        return true
    else
        for r = 1:s-1
            x = mod(x^2, n)
            #@show r, x
            if(x == 1)
                return false
            end
            if(x == n-1)
                return true
            end
        end
    end
    return false
end

function miller_rabin(n, k)
    for trial  = 1:k
        a = rand(2:n-2)
        res = miller_rabin_a(n, a)
        @show a, res
        if(res == false)
            return false
        end
    end
    return true
end




@show rewrite(221) # -> (55,2)
@show miller_rabin_a(221, 174) # -> true
@show miller_rabin_a(221, 137) # -> false

@show miller_rabin(221, 10)
@show miller_rabin(587, 10)

