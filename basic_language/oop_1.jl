# using multiple dispatch to "simulate" OOP features
# define a strcuture with some fields
struct Cls
  x :: Number
  y :: Number
end

# a "method" which acts on the class
function toStr(this::Cls)
  vx = this.x
  vy = this.y
  "Point with coordinates ($vx, $vy)"
end

# overwrite an "operator" (which is a normal function). Requires Base. & the name is :+!
function Base.:+(a::Cls, b::Cls)
  Cls(a.x+b.x, a.y+b.y)
end
  


Base.show(io::IO, c::Cls) = print(io, "(", c.x, " ", c.y, ")")


c1 = Cls(3,4)
println(toStr(c1))
# requires the Base.show method above
c1


c2 = Cls(10,11)
c1 + c2

