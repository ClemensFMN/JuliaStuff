
function quicksort(lst)
    swpd = true

    while(swpd == true)
        swpd = false
        @show lst
        for i = 2:length(lst)
            if(lst[i-1] > lst[i])
                lst[i-1],lst[i] = lst[i],lst[i-1]
                swpd = true
            end
            @show i, lst
        end
        readline()
    end
    return(lst)
end

lst =[5, 6, 1, 7, 3, 2, 4, 9, 8]

res = quicksort(lst)
println(res)
