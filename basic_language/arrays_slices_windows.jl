# Arrays, Slides, and Windows

# a simple array
ar = [1,2,3,4,5]

# Create a slice. A slice is a copy; changing the slice does not change the original
sl = ar[2:3]
sl .= 10 # btw, we need a broadcast to assign a single vlaue to *all* elements

@show sl
@show ar

# Create a view. A view is a looking glass into a array (or part of). Changing the 
# view changes the underlying element
vw = @view ar[2:3]

vw .= 10

@show vw
@show ar
