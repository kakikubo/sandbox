#! /usr/bin/env ruby

require 'robotex'

robotex = Robotex.new "My User Agent name Like WebCrawler"
p robotex.allowed?("http://www.yahoo.co.jp")
p robotex.allowed?("https://www.facebook.com")
p robotex.allowed?("https://www.iijmio.jp/")

# >> true
# >> false
# >> true
