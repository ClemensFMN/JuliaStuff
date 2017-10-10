mutable struct ECSystem
# representing a curve y^2 \equiv x^3 + ax + b \bmod p
    p :: Integer
    a :: Integer
    b :: Integer
end

# a point on an elliptic curve
mutable struct ECPoint
    s :: ECSystem
    x :: Integer
    y :: Integer
end

immutable ECId
end

# a group element on an elliptic curve can be either a point or the identity element
ECGroupElement = Union{ECPoint, ECId}


# interestingly, there seems to be some kind of short function definition...
# neverthless, we need to extend the Base function - to avoid ambiguities, we need to say (==)
Base.:(==)(p1::ECPoint, p2::ECPoint) = (p1.x == p2.x) && (p1.y == p2.y)

function Base.:(==)(p1::ECGroupElement, p2::ECGroupElement)
    if(p1==ECId & p2 == ECId) true
    elseif(p1 == ECPoint & p2 == ECPoint)
        p1 == p2
    else
        false
    end
end


# overload the + operator to work with points on elliptic curves
function Base.:+(p1::ECPoint, p2::ECPoint)
    if(p1.s.p != p2.s.p)
        error("same p required")
    end
    p = p1.s.p
    if(p1==p2)
        s = (3*p1.x^2 + p1.s.a) * invmod(2*p1.y, p)
        s = mod(s, p)
    else
        if(p1.x == p2.x) return ECId()
        else
            s = (p2.y - p1.y) * invmod(p2.x - p1.x, p)
            s = mod(s, p)
        end
    end

    tempx = s^2 - p1.x - p2.x
    tempy = s*(p1.x - tempx) - p1.y
    ECPoint(p1.s, mod(tempx, p), mod(tempy, p))
end



function Base.:+(p1::ECGroupElement, p2::ECGroupElement)
    if(typeof(p1) == ECId)
        p2
    elseif(typeof(p2) == ECId)
        p1
    else
        p1 + p2
    end
end

# other option for the plus function
#Base.:+(p1::ECPoint, p2::ECId) = p1
#Base.:+(p1::ECId, p2::ECPoint) = p2
#Base.:+(p1::ECId, p2::ECId) = ECId()


# based on Understanding Cryptography, Section 9.2
s = ECSystem(17, 2, 2)


pId = ECId()

# a starting point
p1 = ECPoint(s, 5, 1)


# some testing
println(pId + pId)
println(pId + p1)
println(p1 + pId)

println("*******************")

pnew = p1

for i=1:20
    pnew = p1 + pnew
    println(pnew)
end

