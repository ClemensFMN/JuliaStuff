# Example from Todd K. Moon, Error Correction Coding, Example 3.7

# generator matrix
G = [0 1 1 1 1 0 0 ; 1 0 1 1 0 1 0;1 1 0 1 0 0 1];


#for k=0:7
#    m = digits(k, 2, 3)
#    println(m, m'*G)
#end


# let's build the table linking syndrome to error
H = [eye(4) G[:,1:4]']

tbl = Dict()

for k=0:2^7-1

    m = digits(k, 2, 7)
    s = m'*H'
    
    # error pattern -> syndrome
    tbl[m] = map(x -> mod(x,2), s)
    
end


syn = [1 1 0 1]

for k = keys(tbl)

    if(tbl[k] == syn)
        # println(k, syn)
        println(k)
    end
    
end
