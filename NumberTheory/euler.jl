"""
   euclidean_gcd(a, b)

Calculate the gcd using the (iterative) Euler algorithm
"""
function euclidean_gcd(a, b)
    while b!= 0
        t = b
        b = mod(a, b)
        a = t
    end
    return a
end

"""
   ext_euclidean_gcd(a, b)

Calculate the gcd and x, y using the (iterative) extended Euler algorithm so that x * a + y * b = gcd(a,b).
"""
function ext_euclidean_gcd(a, b)
    x = 1
    y = 0
    x1 = 0
    y1 = 1
    a1 = a
    b1 = b
    while(b1 != 0)
        q = div(a1, b1)
        x, x1 = x1, x - q*x1
        y, y1 = y1, y - q*y1
        a1, b1 = b1, a1 - q*b1
    end
    return a1,x, y
end

# euclidean_gcd(3,4) -> 1
# euclidean_gcd(3,9) -> 3
# euclidean_gcd(9,3) -> 3
# euclidean_gcd(8, 34) -> 2


# ext_euclidean_gcd(8,34) -> (2, -4, 1)
# ext_euclidean_gcd(8,45) -> (1, 17, -3)
