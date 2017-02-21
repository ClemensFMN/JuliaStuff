# something a bit more advanced: creating Fibonacci numbers
immutable Fib
    maxval::Int
end


function Base.start(F::Fib)
    return((1,1))
end

function Base.next(F::Fib, state)
    newstate = (state[1] + state[2], state[1])
    val = state[1]
    return((val, newstate))
end

function Base.done(F::Fib, state)
    return(state[1] > F.maxval)
end


for i in Fib(50)
    println(i)
end
