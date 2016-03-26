#! /usr/bin/env ruby

require 'anemone'

# Anemoneの既存仕様を変更
# Usage
# require 'anemone'
# require './anemone-ext'
module Anemone
  class Page

    # utf-8へ変換するように拡張
    def doc
      return @doc if @doc
      if @body && html?
          if charset == 'utf-8' || charset.nil?
              body = @body
          else
              body = @body.encode(
                  "UTF-8", charset, :invalid => :replace,
                  :undef => :replace) rescue nil
          end
          @doc = Nokogiri::HTML(body) if body
      end
    end

    # 文字コードをcharsetタグから取り出す処理を追加
    def charset
      matcher = content_type.match(/charset=[\"]?([a-zA-Z\_\-\d]*)[\"]?/)
      matcher[1].downcase if matcher
    end
  end
end
