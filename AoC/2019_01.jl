
function fuel(mass)
    return convert(Int, floor(mass / 3) - 2)
end

function fuelfuel(mass)
    res = Int[]
    f1 = fuel(mass)
    append!(res, f1)
    fadd = fuel(f1)
    while(fadd > 0)
        append!(res, fadd)
        fadd = fuel(fadd)
    end
    return sum(res)
end

    

inp = readlines("2019_01.txt")

inp_int = map(x -> parse(Int, x), inp)

# problem 1
fuel_vals = map(x -> fuel(x), inp_int)
println(sum(fuel_vals))

# problem 2
fuel_vals = map(x -> fuelfuel(x), inp_int)
println(sum(fuel_vals))
