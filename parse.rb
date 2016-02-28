#! /usr/bin/env ruby
# coding: utf-8
require 'cgi'

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

puts format_text("www.sbcr.jp トピックス", "http://crawler.sbcr.jp/samplepage.html",
                 parse(`~/brew/bin/wget -q -O- http://crawler.sbcr.jp/samplepage.html`))
