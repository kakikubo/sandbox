#! /usr/bin/env ruby
require 'anemone'
require 'nokogiri'
require 'kconv'

urls = []
urls.push("https://www.iijmio.jp/customer/contract/")

cookies = {
  :_ga   => "GA1.2.727066035.1457267634",
  :_gat  => "1",
  :ac    => "14197647234990",
  :krtvis => "3574888420_1452949011525_555679464",
  :JSESSIONID => "abcbigcTzfIBCgsAbnsov",
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
    mainContents = doc.xpath('//*[@id="main-contents"]//tr')
    mainContents.each {|main_contents|
      puts main_contents.content
    }
  end
end
