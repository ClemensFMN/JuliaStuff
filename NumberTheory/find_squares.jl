
n = 7

for a in 0:n
    for b in 0:n
        if(rem(a^2, n) == rem(b^2, n))
            @show a, b
        end
    end
end

