require "rubygems" unless defined?(Gem::VERSION)
require "addressable/uri" # gem install addressable

uri = Addressable::URI.parse("http://mysite.com/some_api")
uri = Addressable::URI.parse("https://mysite.com/thing?foo=bar")

# URI will also guess the correct port
Addressable::URI.parse("http://foo.com").port # => 80
Addressable::URI.parse("https://foo.com/").port # => 443

# Full reference
uri = Addressable::URI.parse("http://foo.com/this/is/everything?query=params")
# p (uri.methods - Object.methods).sort
p uri.scheme        # => "http"
p uri.host          # => "foo.com"
p uri.port          # => 80
p uri.request_uri   # => "/this/is/everything?query=params"
p uri.path          # => "/this/is/everything"
p uri.query         # => "query=params"

# There are setters as well
uri.port = 8080
uri.host = "google.com"
uri.scheme = "ftp"
p uri.to_s
# => "ftp://google.com:8080/this/is/everything?query=param"

require 'uri'
funkyurl = "http://foo.com/#auto|en|Pardon"
begin
  puts "Trying URI on #{funkyurl} ..."
  uri = URI.parse(funkyurl)
  puts "URI ok"
rescue URI::InvalidURIError
  puts "Caught: #{$!}"
  puts "Trying Addressable::URI on #{funkyurl} ..."
  uri = Addressable::URI.parse(funkyurl)
  puts "Addressable::URI ok"
end
