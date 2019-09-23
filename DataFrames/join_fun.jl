using DataFrames

people = DataFrame(ID = [20, 40], Name = ["John Doe", "Jane Doe"])
jobs = DataFrame(ID = [20, 40], Job = ["Lawyer", "Doctor"])

println(join(people, jobs, on = :ID))

# 6 join types
# consider now
jobs = DataFrame(ID = [20, 60], Job = ["Lawyer", "Astronaut"])

join(people, jobs, on = :ID, kind = :inner)
join(people, jobs, on = :ID, kind = :left)
join(people, jobs, on = :ID, kind = :right)
join(people, jobs, on = :ID, kind = :outer)
join(people, jobs, on = :ID, kind = :semi)
join(people, jobs, on = :ID, kind = :anti)

# finally a cross-product
join(people, jobs, kind = :cross, makeunique = true)

jobs = DataFrame(newID = [20, 60], Job = ["Lawyer", "Astronaut"])
join(people, jobs, on = :ID => :newID, kind = :inner)
