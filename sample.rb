#! /usr/bin/env ruby
require 'anemone'

opts = {
  :delay => 1
}

Anemone.crawl("http://localhost:7777",opts) do |anemone|
  puts anemone
end
