# A simple example of a function with a docstring
# use ? f1 at the REPL to display the information about the function


"""
    f1(x,y)

Some stupid function adding the two numbers `x` and `y`.


# Examples
```jldoctest
julia> f1(3,4)
7
```
"""
function f1(x,y)
  x+y
end