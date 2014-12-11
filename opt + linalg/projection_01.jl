

# define a matrix with two non-zero column vectors
A = [1 0 0; 0 1 0; 0 0 0]


x = [1;2;3]


# the columns of A are orthonormal -> we can use A*x for projecting x onto the
# column space of A 

A * x

# The more elegant / robust method is to use the pseudo-inverse of A for all
# project adventures

A = [1 0; 0 1; 0 0]

PA = A * inv(A' * A) * A'

# this yields the projection of x onto the column space of A
println(PA * x)

#the error term x - PA*x is orthogonal to the column space of A
A' * (x - PA*x)

# using the pseudo-inverse for projection, the column vectors of A can be
# "anything"
A = [1 -2; 3 1; 0 0]
PA = A * inv(A' * A) * A'
println(PA * x)



