using DataFrames


function stock_cor(tbl_1, tbl_2)

         jtbl = join(tbl_1, tbl_2, on=:Date);

         series1 = convert(Array, jtbl[:Adj_Close])
         series2 = convert(Array, jtbl[:Adj_Close_1])

         return(cor(series1, series2))
end



daxtbl = readtable("DAX.csv");
bmwtbl = readtable("BMW.csv");
nikkeitbl = readtable("Nikkei225.csv");
batbl = readtable("bangkok_airways.csv");
appletbl = readtable("apple.csv");


println(stock_cor(daxtbl, bmwtbl))
println(stock_cor(daxtbl, nikkeitbl))
println(stock_cor(bmwtbl, batbl))
println(stock_cor(daxtbl, batbl))
println(stock_cor(nikkeitbl, batbl))

println(stock_cor(daxtbl, appletbl))
println(stock_cor(bmwtbl, appletbl))

println(stock_cor(batbl, appletbl))