#! /usr/bin/env ruby
# coding: utf-8
require 'cgi'
require 'open-uri'
require 'kconv'
require 'rss'

#  % wget -O samplepage.html http://crawler.sbcr.jp/samplepage.html
def parse(page_source)
  dates = page_source.scan(%r!(\d+)年 ?(\d+)月 ?(\d+)日<br />!)
  url_titles = page_source.scan(%r!^<a href="(.+?)">(.+?)</a><br />!)
  url_titles.zip(dates).map{ |(aurl, atitle),ymd |
    [CGI.unescapeHTML(aurl), CGI.unescapeHTML(atitle), Time.local(*ymd)]
  }
end

def format_text(title, url, url_title_time_ary)
  s = "Title: #{title}\nURL: #{url}\n\n"
  url_title_time_ary.each do |aurl, atitle, atime|
    s << "* (#{atime}#{atitle}\n"
    s << "     #{aurl}\n"
  end
  s
end

def format_rss(title, url, url_title_time_ary)
  RSS::Maker.make("2.0") do |maker|
    maker.channel.updated = Time.now.to_s
    maker.channel.link = url
    maker.channel.title = title
    maker.channel.description = title
    url_title_time_ary.each do |aurl, atitle, atime|
      maker.items.new_item do |item|
        item.link = aurl
        item.title = atitle
        item.updated = atime
        item.description = atitle
      end
    end
  end
end

formatter = case ARGV.first
when "rss-output"
  :format_rss
when "text-output"
  :format_text
else
  :format_text
end

#parsed = parse(open("http://crawler.sbcr.jp/samplepage.html", "r:UTF-8", &:read))
parsed = parse(open("http://crawler.sbcr.jp/samplepage.html", &:read).toutf8)

puts __send__(formatter,
              "www.sbcr.jp トピックス",
              "http://crawler.sbcr.jp/samplepage.html",  parsed)

# ex.) ./rssserver.rb rss-output
