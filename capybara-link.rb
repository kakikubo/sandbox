#! /usr/bin/env ruby
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'URI'

Capybara.current_driver = :selenium
Capybara.app_host = "http://www.yahoo.co.jp"
Capybara.default_max_wait_time = 20

module Crawler
  class LinkChecker
    include Capybara::DSL

    def initialize()
      visit('')
      @i = 0
      @base = URI.parse(Capybara.app_host)
    end

    def find_links
      @links = []
      all('a').each do |a|
        u = a[:href]
        next if u.nil? or u.empty?
        next if URI.parse(u).host != @base.host # www.yahoo.co.jpだけ抽出したい
        @links << u
        # 収集するリンクを20に抑える
        break if @links.size >= 30
      end
      @links.uniq!
      puts @links
      @links
    end

    def screenshot(link)
      @i = @i + 1
      puts link
      visit(link)
      page.save_screenshot("screenshot#{@i}.png")
    end
  end
end

crawler = Crawler::LinkChecker.new
links = crawler.find_links
links.each {|link|
  crawler.screenshot(link)
}
