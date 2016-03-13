#! /usr/bin/env ruby
# coding: utf-8

require 'anemone'

Anemone.crawl("http://www.yahoo.co.jp") do |anemone|
  # adminを含むURLは除外
  anemone.skip_links_like /\/r\// # !> ambiguous first argument; put parentheses or a space even after `/' operator
  anemone.on_every_page do |page|
    puts page.url
  end
end
