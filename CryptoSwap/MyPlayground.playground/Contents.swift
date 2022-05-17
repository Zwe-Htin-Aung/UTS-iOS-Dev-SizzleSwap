import UIKit


var baseUrl = "https://api.coingecko.com/api/v3"
var topCoinsUrl = "/coins/markets?vs_currency=aud&order=market_cap_desc&per_page=100&page=1&sparkline=false"

let baseAndEndURL = baseUrl+topCoinsUrl
print(baseAndEndURL)
