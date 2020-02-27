using LightGraphs

# use LightGraph for the Cormen example (/home/clnovak/src/julia/JuliaStuff/algorithms/graphs_bfs.jl)
# and /home/clnovak/src/latex/Journal/2020-02-24-bfs.tex

# map names to numbers
# r -> 1, s -> 2, t -> 3, u -> 4, v -> 5, w -> 6, x -> 7, y -> 8

g = Graph(8)
add_edge!(g,1,5) # r - v
add_edge!(g,1,2) # r - s
add_edge!(g,2,6) # s - w
add_edge!(g,3,6) # t - w
add_edge!(g,3,7) # t - x
add_edge!(g,3,4) # t - u
add_edge!(g,4,7) # u - x
add_edge!(g,4,8) # u - y
add_edge!(g,6,7) # w - x
add_edge!(g,7,8) # x - y



println(collect(edges(g)))

bfs = bfs_tree(g,1)

collect(edges(bfs))

