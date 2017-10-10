using Winston

# generate all possible paths starting and ending in the first city
function alltours(cities)
	fst = cities[1]
	return [[fst;x;fst] for x in permutations(cities[2:end])]
end


function dist(city_coord, start, stop)

	delta_x = city_coord[start][1] - city_coord[stop][1]
	delta_y = city_coord[start][2] - city_coord[stop][2]

	delta_x^2 + delta_y^2

end


# calculate the path length given city coordinates city_coord and path
function tour_length(city_coord, path)

	path_length = 0
	# go over all segments of path
	for ind in 1:length(path)-1
		# start / stop city of segment
		start = path[ind]
		stop = path[ind+1]
		# distance of the segment
		delta = dist(city_coord, start, stop)
		# and update the distance of the path
		path_length += delta
	end
	path_length
end


# start in city "start"; select the next city based on nearest neighbour
function nearest_neighbour_path(city_coord, start)

	path = [start]
	N = length(city_coord)
	path_length = 0

	# we keep a list of unvisited cities
	unvisited = collect(1:N)
	# which is all cities but the start city
	ind_to_remove = find(unvisited .== start)
	deleteat!(unvisited, ind_to_remove)

	# go as long as we have unvisited cities
	while(length(unvisited)>0)
		# calculate the distance from the current start city to all others
		dists = [dist(city_coord, start, x) for x in unvisited]
		# take the minimum city
		val, ind = findmin(dists)
		# update the path
		path = [path; unvisited[ind]]
		# update the path length
		path_length += val
		# and set the current city as the new start city
		start = unvisited[ind]
		# remove the current / new city from the unvisited cities
		ind_to_remove = find(unvisited .== unvisited[ind])
		deleteat!(unvisited, ind_to_remove)
	end
	# close the path
	path = [path; path[1]]
end

#number of cities
N = 10
# the different cities
cities = collect(1:N)


RUNS = 100

val_opt = zeros(RUNS)
val_nn = zeros(RUNS)


for iter in 1:RUNS

#srand(1234)
	# the coordinates of the cities - a list of (x,y) tuples
	city_coords = [(rand(1:50), rand(1:50)) for i in 1:length(cities)]

	res = alltours(cities)

	path_len = zeros(length(res))

	for path in 1:length(res)
		path_len[path] = tour_length(city_coords, res[path])
		#println(res[path], " -> ", path_len[path])
	end

	val, ind = findmin(path_len)
	#println("Optimum")
	#println(res[ind], " -> ", val)
	val_opt[iter] = val

	nn_path = nearest_neighbour_path(city_coords, 1)
	#println("NN")
	#println(nn_path, " -> ", tour_length(city_coords, nn_path))
	val_nn[iter] = tour_length(city_coords, nn_path)

end

#println([val_opt val_nn 100*(val_nn-val_opt)./val_opt])

x = val_nn./val_opt
hst = hist(x, 10)

frm = Winston.FramedPlot(title="", xlabel="x", ylabel="Density")
Winston.add(frm, Winston.Histogram(hst[1], hst[2], color="red"))



