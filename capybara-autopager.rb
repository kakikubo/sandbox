#! /usr/bin/env ruby
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'multi_json'
require 'autopagerize'

Capybara.current_driver = :selenium
Capybara.app_host = "http://www.amazon.co.jp/s/?url=search-alias%3dstripbooks&field-keywords=sexy"
Capybara.default_max_wait_time  = 20

module Crawler
  class LinkChecker
    include Capybara::DSL

    def initialize()
      visit('')
      url = Capybara.app_host
      siteinfo = MultiJson.load(
        File.read("siteinfo.json")
      )
      @page = Autopagerize.new(url, siteinfo, :maxpage => 3)
    end

    def get_nextlink
      page_number = 1
      @page.each do |page|
        visit(page.nextlink)
        save_screenshot("screenshot#{page_number}.png")
        page_number += 1
      end
    end

  end
end

crawler = Crawler::LinkChecker.new
crawler.get_nextlink
