# this is inspired by Programming Challenges 2.8.6
# finding the Erdös number
using LightGraphs

# every publication's author is modeled as vertex of a graph if authors have
# written a paper together, their vertices is connected by an edge

# e.g.
# publication 1 with authors 1,2,3
# publication 2 with authors 1,2,5
# publication 3 with authors 3,4,5


g = Graph(5)
add_edge!(g,1,2) # pub 1, 2
add_edge!(g,1,3) # pub 1
add_edge!(g,1,5) # pub 2
add_edge!(g,2,5) # pub 2
add_edge!(g,3,5) # pub 3
add_edge!(g,4,5) # pub 3


# let "special node" 1 be Erdös; then the distance between vertex N
# and 0 is the Erdös number e.g. find the erdös number of author 4:
path = a_star(g, 1, 4)

println(length(path))

# what the approach does NOT catch is the publication path; i.e. the
# information via which publications the authors are linked is lost.
# We could model this via edge attributes; e.g. store the publication
# name (or a pointer to the publication) in the edge and allow
# multiedges (two edges between 1 and 2). LightGraphs does not support
# edge attribues, but MetaGraph does
