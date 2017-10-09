# determine nuber of divisions for gcd calculation

function gcd_count(a::T, b::T) where T<:Integer
	count = 0
    while b != 0
        t = b
        b = rem(a, b)
        a = t
        count += 1
    end
    # checked_abs(a)
    (a, count)
end



# println(gcd_count(10,3))


ndigits = 2:8



RUNS = 10000
cnt_vec = zeros(length(ndigits), RUNS)

for (indn, val) in enumerate(ndigits)

    numrange = 10^(val-1):10^val
    println(numrange)

    for (ind, ) in enumerate(1:RUNS)
        a = rand(numrange)
        b = rand(numrange)
        r, cnt = gcd_count(a,b)
        cnt_vec[indn, ind] = cnt
    end

end




using Plots
plotly()



# plot(ndigits, mean(cnt_vec,2), lab="", xlabel="digit length a, b", ylabel="avg num divisions", grid=true)

histogram(cnt_vec[3,:], bins=50, xlabel="# of divisions", ylabel="# of occurences", lab="", grid=true)

