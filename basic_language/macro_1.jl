# based on https://github.com/JuliaComputing/JuliaBoxTutorials/blob/master/advanced-julia/Metaprogramming.ipynb


# define an expression
x = :(2+2)
@show eval(x)

# build up expressions
y = :($x * $x)
@show eval(y)

# assign ex an expression - this needs an eval before the function is defined
ex = :(foo() = println("I'm foo!"))
@show eval(ex)
foo()


# this creates an expression which adds to values
plus(a, b) = :($a + $b)

@show reduce(plus, 1:10)
@show reduce(plus, [:(x^2), :x, 1])

# we create the terms of the sin Taylor series
terms = [:($((-1)^k) * x^$(1+2k) / $(factorial(1+2k))) for k = 0:5]

# sum them up
ex = :(mysin(x) = $(reduce(plus, terms)))
@show ex

# this creates the actual mysin expression
eval(ex)
[mysin(0.5) sin(0.5)]




