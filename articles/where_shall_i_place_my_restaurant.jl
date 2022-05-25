using PyPlot


# count the number of paths between (0,0) and (M,N) wihc go through (a,b)
# TODO: Check agsint paper
function cnt(m,n,a,b)
   part1 = binomial(m-a+n-b, m-a)
   part2 = binomial(a+b,a)
   part1 * part2
end


M = 5
N=  3

avec = 0:M
bvec = 0:N

# we can get the 2-dim result via the list comprehension below - careful: one for expression & , separating the variables!
val = [cnt(M,N,a,b) for a in avec, b in bvec]

fig, ax = plt.subplots()
# Using matshow here just because it sets the ticks up nicely. imshow is faster.
# inspired by https://stackoverflow.com/questions/20998083/show-the-values-in-the-grid-using-matplotlib
ax.matshow(val, cmap="seismic")

val_idx = [(a,b, val[a+1,b+1]) for a in avec for b in bvec]

for (i, j, v) in val_idx
    # ax.text(j, i, v, ha="center", va="center")
    # this bbox is a bit tricky as it requires a Dict...
    ax.text(j, i, v, ha="center", va="center", bbox=Dict(:boxstyle => "round", :facecolor=>"white", :edgecolor=>"0.3"))
end
