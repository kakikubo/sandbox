#! /usr/bin/env ruby
# coding: utf-8

require 'selenium-webdriver'

# ブラウザの起動
driver = Selenium::WebDriver.for :firefox

# Waitの設定
driver.manage.timeouts.page_load = 10

driver.navigate.to 'https://twitter.com/search-home'

elements = driver.find_elements(:xpath, "//ul[@class='trend-items js-trends']/li/a")
elements.each do |element|
  # Tweetの表示
  puts element.text
end

driver.quit
