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


using Plots
plotly()


a = 55

num_div = map(x-> gcd_count(a,x)[2],1:a)

plot(1:a, num_div, xlabel="b", ylabel="num divisions")

#savefig("num_div.png")


