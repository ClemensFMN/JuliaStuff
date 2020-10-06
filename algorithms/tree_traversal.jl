using DataStructures

mutable struct Node
    children :: Array{Node}
    ID::Int64
    Node(ID::Int64)= new(Array{Node,1}(), ID)
    Node(n::Array{Node, 1}, ID::Int64) = new(n, ID)
end


# simple recursive DFS algorithm
function DFS_recursive(n::Node)
    println(n.ID)

    for c in n.children
        DFS_recursive(c)
    end
end


# DFS using a stack
function DFS_stack(n::Node)
    s = Stack{Node}()
    push!(s, n)

    while(length(s) > 0)
        temp = pop!(s)
        println(temp.ID)
        for c in reverse(temp.children) # for some weid reason we need to push the children in the reverse order onto the stack...
            push!(s, c)
        end
    end
end

# BFS using a queue
function BFS_queue(n::Node)
    q = Queue{Node}()
    enqueue!(q,n)

    while(length(q) > 0)
        println(first(q).ID)
        temp = dequeue!(q)
        for c in temp.children
            enqueue!(q, c)
        end
    end
end





t1 = Node([Node(4), Node(5)], 2)
t2 = Node([Node(6), Node(7)], 3)
t = Node([t1, t2], 1)


tnew = Node([Node([Node(4), Node(5)], 2), 
       Node([Node(6), Node(7)], 3)],
       1)

DFS_recursive(tnew)
DFS_stack(tnew)
BFS_queue(tnew)
