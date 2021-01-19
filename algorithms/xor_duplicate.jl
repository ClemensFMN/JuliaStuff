# based on https://florian.github.io/xor-trick/

# Application 2
# You are given an array A of n - 1 integers which are in the range between 1 and n. 
# All numbers appear exactly once, except one number, which is missing. 
# Find this missing number.

# XOR observation xor(A, A) = 0
xor(39434, 39434) # -> 0

# The idea is to append to A the elements 1:n and xor everything together
# all elements but the missing one are duplicated
# the XOR removes all duplicates, left is the missing element

n = 5
A = [1,3,4,5]

Aappended = [A ;1:n]

# we need to xor all elements together and use a fold(left) for this purpose...
mssng = foldl(xor, Aappended)

# Aplication 3
# You are given an array A of n + 1 integers which are in the range between 1 and n.
# All numbers appear exactly once, except one number, which is duplicated.
# Find this duplicated number.

# Same principle, when we append the range 1:n, then all elements are duplicated but
# the one which was already duplicated in A. This appears now three times.
# Xoring everything together, zeros all but the original duplicate

A = [1,1,2,3,4,5]
Aappended = [A ;1:n]

dplctd = foldl(xor, Aappended)

