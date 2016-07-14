
RUNS = round(Int, 1e8)
# nc_vec = zeros(RUNS)

nc_total = 0

# number of different coupons
N = 10

# how many different coupons do we want in order to quit?
K = 5

for i in 1:RUNS

    # number of coupons (including duplicates)
    nc = 0

    # number of different coupons seen so far
    k = 0

    # list of coupons we already have
    coupons_seen = zeros(K)

    while(k < K)
       cp = rand(1:N)
       # println(cp)
       nc = nc+1

       if(in(cp, coupons_seen) == false)
          k = k+1
	  coupons_seen[k] = cp
       end
   end
   # (nc, coupons_seen)
   #nc_vec[i] = nc
   nc_total = nc_total+nc
end

# mean(nc_vec)
println(nc_total / RUNS)

# analytical solution
println(sum(N ./ (N-K+1:N)))