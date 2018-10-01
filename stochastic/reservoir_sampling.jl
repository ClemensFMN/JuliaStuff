# we want to check whether reservoir sampling generates a uniform distribution
# to this end, we fix N, the number of elements the stream provides

# number of algorithm runs
RUNS = 1_000_000
# store the numnber of occurence per run
probs = Dict()

for r in 1:RUNS

  N = 30 # how many elements does the stream produce
  stream_alphabet = 1:20

  slctn = rand(stream_alphabet) # start the stream with a random element 
  # @show slctn

  for i=2:N
    obs = rand(stream_alphabet) # our new observation
    r = rand() # decide whether we want to keep the old value or change it
    if r < 1/i
      slctn = obs
      # println("changed")
    end
    # @show i, obs, slctn
  end
  probs[slctn] = get(probs, slctn, 0) + 1 # update the dict of observed values
end

@show probs
