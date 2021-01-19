import HTTP
import JSON

url = "http://httpbin.org/json"


res = HTTP.request("GET", url, ["Content-Type" => "application/json"])
println(res)

s = String(res.body)
prsd = JSON.parse(s)
