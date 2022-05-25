using Luxor


Drawing(1000, 1000, "hello-world.png")

background("black")
sethue("red")

line(Point(0,0), Point(500,500), :stroke)

finish()
preview()
