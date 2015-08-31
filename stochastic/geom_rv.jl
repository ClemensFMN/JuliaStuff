
function rnd_int(p)
	rand() < p
end


function rand_seq(p)
	steps = 0
	got_true = false

	while(got_true==false)
		got_true = rnd_int(p)
		steps = steps + 1
	end
	steps
end


function rand_seq(p, N)
	success = 0
	for i=1:N
		if(rnd_int(p))
			success = success + 1
		end
	end
	success
end


p = 0.2

N = 1000000

steps = zeros(N)

for i=1:N
	steps[i] = rand_seq(p)
end

# there is a difference between empirical and theoretical results by one due
# to "different counting methods"
println(mean(steps)-1)
println((1-p)/p)


# count the number of successes in a sequence
sc = rand_seq(p, N)
println(sc)
# which should be equal the sequence length / the mean distance between
# successes (again corrected by the "different counting method")
println(N/((1-p)/p+1))

