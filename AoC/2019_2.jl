


dta = [1,9,10,3,2,3,11,0,99,30,40,50]

pos = 1
cmd = dta[pos]

while(cmd != 99)

    op1 = dta[pos+1]
    op2 = dta[pos+2]

    if(cmd == 1)
        res = op1 + op2
    elseif(cmd == 2)
        res = op1 + op2
    end

    dta[pos+3] = res
    pos += 4
    cmd = dta[pos]
end

    



