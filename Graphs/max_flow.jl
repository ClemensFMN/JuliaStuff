using LightGraphs, LightGraphsFlows


const LG = LightGraphs
flow_graph = LG.DiGraph(6)

flow_edges = [(1,2,16), (1,3,13),
              (2,4,12),
              (3,2,4), (3,5,14),
              (4,3,9), (4,6,20),
              (5,4,7), (5,6,4)]

capacity_matrix = zeros(Int, 6, 6)  # Create a capacity matrix

for e in flow_edges
    u, v, f = e
    LG.add_edge!(flow_graph, u, v)
    capacity_matrix[u,v] = f
end


# f, F = maximum_flow(flow_graph, 1, 6)
f, F = maximum_flow(flow_graph, 1, 6, capacity_matrix)
