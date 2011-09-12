require "net/http"
require "uri"

MAX_REDIRECTS = 10
url = ARGV.shift || "http://google.com/"
depth = 0
begin
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  puts "GET #{url} #{response.inspect} #{response['Location'].inspect if response['Location']}"
end while response.kind_of?(Net::HTTPRedirection) && (url = URI.join(url, response['Location']).to_s) && (MAX_REDIRECTS > (depth+=1))
puts "Final: #{url} #{response.inspect}"
