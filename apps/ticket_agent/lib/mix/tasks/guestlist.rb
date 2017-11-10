require 'uri'
require 'net/http'

0.upto(13).each do |x|
  offset = x * 1000
  puts "offset == #{offset}"

  url = URI("https://www.universe.com/api/v2/guestlists?limit=1000&offset=#{offset}")
  puts "Downloading #{url}"

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request["authorization"] = 'Bearer aa3253e90bcfd384b8affd1f384d2a151bb08ea839a4b373637a114d75040dda'

  response = http.request(request)
  # puts

  File.open("/Users/patrickveverka/Code/Personal/ticket_agent/lib/mix/tasks/guestlist#{x}.json", 'wb') {|f| f.write(response.read_body ) }


end
