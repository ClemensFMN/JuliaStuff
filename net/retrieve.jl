using HTTP


r = HTTP.request("GET", "http://httpbin.org/ip"; verbose=3)
println(r.status)
println(String(r.body))
