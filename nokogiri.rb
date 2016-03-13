require 'open-uri'
require 'nokogiri'

doc = Nokogiri.HTML(open("http://nokogiri.org/"))

doc.css("a").each do |element|
  puts element[:href]
end
