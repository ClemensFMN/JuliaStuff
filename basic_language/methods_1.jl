function f(x::Float64, y::Float64)
    return(x + y)
end

function f(x::Number, y::Number)
    return(x - y)
end

# the catch-all method
function f(x,y)
    return("Not defined")
end


# typing "f" at the REPL provides
# f (generic function with 2 methods)
# typing methods(f) at the REPL provides
# # 2 methods for generic function "f":
# f(x::Float64, y::Float64) at /home/clnovak/d/p/src/julia/JuliaStuff/basic_language/methods_1.jl:2
# f(x::Number, y::Number) at /home/clnovak/d/p/src/julia/JuliaStuff/basic_language/methods_1.jl:6

# run it

println(f(2.0, 3.0))
println(f(2,3.0))
println(f(2,"A"))
