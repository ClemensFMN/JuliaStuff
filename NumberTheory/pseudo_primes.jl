using Plots
plotly()
using Primes

# calculate the pseudoprimes of a given composite number n
function getPseudoPrimes(n)
    n = BigInt(n)
    cnt = 0
    pp = []
    avec = 1:n
    for a in avec
        # calc a^n \mod n
        a = BigInt(a)        
        x = mod(a^n, n)        
        # x = powermod(a,n,n)
        if(x == a)
            push!(pp, a)
            cnt += 1
        end
    end
    # return(cnt, pp)
    return(cnt)
end

# pp, cnt = getPseudoPrimes(341)
strt = 101
stp = 1001

nvec = setdiff(strt:2:stp, primes(strt, stp))

res = getPseudoPrimes.(nvec)
plot(nvec, res)