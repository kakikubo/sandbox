#! /usr/bin/env ruby

require 'mechanize'

username = ARGV[0]
password = ARGV[1]

uri=URI.parse("https://affiliate.amazon.co.jp/")
agent = Mechanize.new
agent.user_agent_alias = "Mac Safari"
page = agent.get(uri)
next_page = page.form_with(:name => "sign_in") do |form|
  form.username = username
  form.password = password
end.submit
puts next_page.search('//*[@id="mini-report"]/div[5]/div[2]').text
