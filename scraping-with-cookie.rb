#! /usr/bin/env ruby
require 'anemone'
require 'nokogiri'
require 'kconv'

urls = []
urls.push("http://mixi.jp/home.pl?from=h_logo")

cookies = {
  :_auid => "7c4d435f6cddcbdacdfe5989875d155a",
  :emid  => "e00837a8e104a5c7fca0577f86a03d9ab83fc2c57dfab1400121a2ba2e6e3aa3ad421cf0490cc2",
  :session => "27778762_60917f6dad357c2f3877224a4061b26c_1",
  :stamp => "2f3fea5ddd851809dbb8e50ce4b24763",
  :vntgsync => "1"
}
opts = {
:delay => 1,
:accept_cookies => true,
:cookies => cookies,
:depth_limit => 0
}

Anemone.crawl(urls, opts) do |anemone|
  anemone.on_every_page do |page|
    doc = Nokogiri::HTML.parse(page.body.toutf8)
    communityList = doc.xpath("//*[@id='communityList']//span/a")
    communityList.each {|communityList|
      puts communityList.content
    }
  end
end
