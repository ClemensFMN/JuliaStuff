
# N dice
N = 8
# number of experiments
runs = int(1e7)

# throw N dice, runs times
outcome = rand(1:6, runs, N)

cnt = zeros(runs)


for run=1:runs

	temp = outcome[run,:]
	# count how many ones per dice throw
	cnt[run] = count(x->x==1, temp)

end

# count how often we have more/equal than 2 onces
count(x->x>=2, cnt)/runs


