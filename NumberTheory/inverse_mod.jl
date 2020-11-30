function inverse_mod(a, n)
    t = 0
    newt = 1
    r = n
    newr = a

    while(newr != 0)
        quotient = div(r, newr)
        (t, newt) = (newt, t - quotient * newt) 
        (r, newr) = (newr, r - quotient * newr)
    end

    if(r > 1)
        error("a is not invertible")
    end

    if(t < 0)
        t = t + n
        return t
    else
        return t
    end
end
