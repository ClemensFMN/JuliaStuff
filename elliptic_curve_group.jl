immutable ECSystem
# representing a curve y^2 \equiv x^3 + ax + b \bmod p
    p :: Integer
    a :: Integer
    b :: Integer
end


immutable ECPoint
    s :: ECSystem
    x :: Integer
    y :: Integer
end


# interestingly, there seems to be some kind of short function definition...
# neverthless, we need to extend the Base function - to avoid ambiguities, we need to say (==)
Base.:(==)(p1::ECPoint, p2::ECPoint) = (p1.x == p2.x) && (p1.y == p2.y)


# overload the + operator to work with points on elliptic curves
function Base.:+(p1::ECPoint, p2::ECPoint)
    p = p1.s.p
    # TODO check that both p1.s.p and p2.s.p are equal
    if(p1==p2)
        s = (3*p1.x^2 + p1.s.a) * invmod(2*p1.y, p)
        s = mod(s, p)
    else
        # TODO what happens when p2.x. and p1.x. are equal??
        s = (p2.y - p1.y) * invmod(p2.x - p1.x, p)
        s = mod(s, p)
    end

    tempx = s^2 - p1.x - p2.x
    tempy = s*(p1.x - tempx) - p1.y
    ECPoint(p1.s, mod(tempx, p), mod(tempy, p))
end

# based on Understanding Cryptography, Section 9.2
s = ECSystem(17, 2, 2)

# a starting point
p1 = ECPoint(s, 5, 1)

pnew = p1

for i=1:20
    pnew = p1 + pnew
    println(pnew)
end

