function fermat_kraitchik(n)
    rn = ceil(sqrt(n)) : (n+1)/2 - 1
    for vl in rn
        b = sqrt(vl^2 - n)
        if(isinteger(b))
            print("is composite")
            return((vl+b), (vl-b))
        end
    end
    print("prime")
    return((n, 1))
end

# fermat_kraitchik(119143) -> is composite(421.0, 283.0)
# fermat_kraitchik(5783) -> prime(5783, 1)

