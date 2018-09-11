# define an object with its own iterator
# http://docs.julialang.org/en/stable/manual/interfaces/#man-interfaces-iteration

struct Squares
    count::Int
end

function Base.iterate(S::Squares, state=1)
  if(state > S.count) # we are above the max value
    nothing # -> return nothing to indicate we are done
  else
    (state*state, state+1) # otherwise, return value and new state
  end
end


Base.eltype(::Type{Squares}) = Int

Base.length(S::Squares) = S.count


for i in Squares(7)
  println(i)
end

println(25 in Squares(100))

# we need getindex for accessing []
function Base.getindex(S::Squares, i::Int)
  1 <= i <= S.count || throw(BoundsError(S, i))
  return i*i
end

println(Squares(10)[3])

# this to also allow Numbers as index
Base.getindex(S::Squares, i::Number) = S[convert(Int, i)]
# and this to allow ranges as indices
Base.getindex(S::Squares, I) = [S[i] for i in I]

println(Squares(10)[3:6])
