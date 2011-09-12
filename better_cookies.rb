require "net/http"
require "uri"

begin
  # 1) gem install mechanize
  require "rubygems" unless defined?(Gem::VERSION)
  require 'mechanize'
rescue LoadError
  # 2) or grab your own copy of mechanize/cookie.rb and mechanize/cookie_jar.rb from the gem and ...
  class Mechanize; def self.log; end; end
  require 'mechanize/cookie'
  require 'mechanize/cookie_jar'
end

def fetch_with_cookies(uri, headers = {})
  @cookie_jar ||= Mechanize::CookieJar.new
  if @cookie_jar.empty?(uri) || (cookies = @cookie_jar.cookies(uri)).empty?
    puts "Visiting #{uri.inspect} without cookies"
  else
    headers['Cookie'] = cookies.join('; ')
    puts "Visiting #{uri.inspect} using cookies: #{cookies.inspect} ..."
  end
  res = Net::HTTP.start(uri.host, uri.port) {|http| http.get(uri.request_uri, headers)}
  (res.get_fields('Set-Cookie') || []).each do |cookie|
    Mechanize::Cookie.parse(uri, cookie) { |c| @cookie_jar.add(uri, c) }
  end
  res
end

fetch_with_cookies(URI.parse("http://translate.google.com/"))
fetch_with_cookies(URI.parse("http://translate.google.com/"))
fetch_with_cookies(URI.parse("http://www.google.com/"))
fetch_with_cookies(URI.parse("http://www.yahoo.com/"))
fetch_with_cookies(URI.parse("http://www.google.com/"))
