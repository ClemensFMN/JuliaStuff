function quant(dcsn, repr, x)
    if x < dcsn[1]
        ret = repr[1]
    elseif x > last(dcsn)
        ret = last(repr)
    else
        for k = 1:length(dcsn)-1
            if(x > dcsn[k]) & (x < dcsn[k+1])
                ret = repr[k+1]
            end
        end
    end
    return ret
end    


#dcsn = [-2, -1, 0, 1, 2]
#repr = [-2.5, -1.5, -0.5, 0.5, 1.5, 2.5]

#x = [-2.3, -1.4, -0.1, 0.1, 1.4, 2.3]

#for temp in x
#    y = quant(dcsn, repr, temp)
#    @show temp, y
#end


