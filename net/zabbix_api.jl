import HTTP
import JSON

url = "http://192.168.1.109/zabbix/api_jsonrpc.php"


payload = Dict("jsonrpc" => "2.0",
               "method" => "user.login",
               "params" => Dict("user" => "Admin",
                                "password" => "zabbix"),
               "id" => 1)

res = HTTP.request("POST", "http://192.168.1.109/zabbix/api_jsonrpc.php", ["Content-Type" => "application/json"], JSON.json(payload))
# println(res)

println(JSON.parse(String(res.body)))
