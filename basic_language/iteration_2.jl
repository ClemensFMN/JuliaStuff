# define an object with its own iterator
# http://docs.julialang.org/en/stable/manual/interfaces/#man-interfaces-iteration

immutable Squares
    count::Int
end

# Base.start(::Squares) = 1
# shorthand for
function Base.start(S::Squares)
    return(1)
end

# Base.next(S::Squares, state) = (state*state, state+1)
# shorthand for
function Base.next(S::Squares, state)
    return(state*state, state+1)
end

# Base.done(S::Squares, state) = state > S.count;
# shorthand for
function Base.done(S::Squares, state)
    return(state > S.count)
end

# too lazy for writing out the shorthand
Base.eltype(::Type{Squares}) = Int # Note that this is defined for the type
Base.length(S::Squares) = S.count;

# *********** Application ***********
for i in Squares(7)
    println(i)
end


println(25 in Squares(10))
println(mean(Squares(100)), std(Squares(100)))
