#! /usr/bin/env ruby

require 'anemone'

# Anemone�δ�¸���ͤ��ѹ�
# Usage
# require 'anemone'
# require './anemone-ext'
module Anemone
  class Page

    # utf-8���Ѵ�����褦�˳�ĥ
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

    # ʸ�������ɤ�charset����������Ф��������ɲ�
    def charset
      matcher = content_type.match(/charset=[\"]?([a-zA-Z\_\-\d]*)[\"]?/)
      matcher[1].downcase if matcher
    end
  end
end
