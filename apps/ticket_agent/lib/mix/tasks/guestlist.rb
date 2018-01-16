require 'uri'
require 'net/http'

0.upto(13).each do |x|
  offset = x * 1000
  puts "offset == #{offset}"

  url = URI("https://www.universe.com/api/v2/guestlists?limit=10&offset=#{offset}")
  puts "Downloading #{url}"

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request["authorization"] = 'Bearer 66357af744d1b404ea667eed280c676406c494bd57f9e8778bab52a78f1da47e'

  response = http.request(request)
  # puts

  puts response.read_body
  # File.open("/Users/patrickveverka/Code/Personal/ticket_agent/lib/mix/tasks/guestlist#{x}.json", 'wb') {|f| f.write(response.read_body ) }
  raise "FUCK"

end
