using DataStructures

pq = PriorityQueue{Int, Int}()

enqueue!(pq, 0, 1)
enqueue!(pq, 1, 2)
enqueue!(pq, 2, 10)


println(pq)

while(!isempty(pq))
    res = dequeue!(pq)
    println("Element with ID ", res, " taken")
end
