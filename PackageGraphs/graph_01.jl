using Graphs


pairs = [(1,2), (1,3), (1,4), (2,4), (3,4)]

eds = Edge{Int}[Edge(i,p[1],p[2]) for (i,p) in enumerate(pairs)]

gu = simple_edgelist(5, eds; is_directed=false)


#print(gu)


print(to_dot(gu))