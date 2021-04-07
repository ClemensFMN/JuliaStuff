# let's do the the following
# fix a composite number n = 703 which has 360 pseudo primes

function fermat_test_one(n, a)
    a = BigInt(a)
    n = BigInt(n)
    x = mod(a^(n-1), n)
    # @show x
    if(x == 1)
        return(true)
    else
        return(false)
    end
end

function fermat_test(n, k)
    for iter = 1:k
        a = rand(2:n-2)
        # @show a
        res = fermat_test_one(n, a)
        # @show res
        if(res == false)
            return(false)
        end
    end
    return true
end


function runner(N, k)
    res = zeros(N)
    n = 703
    for iter = 1:N
        res[iter] = fermat_test(n, k)
    end
    return res
end




# n = 703
#fermat_test_one(n, 3) # -> true (Fermat liar)
#fermat_test_one(n, 5) # -> false

N = 1000
k = 5
res = runner(N, k)
@show sum(res) / N
@show (360/703)^k
