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

puts #{__send__}

puts __send__(formatter,
              "www.sbcr.jp トピックス",
              "http://crawler.sbcr.jp/samplepage.html",  parsed)

# ex.) ./rssserver.rb rss-output
# >> Title: www.sbcr.jp トピックス
# >> URL: http://crawler.sbcr.jp/samplepage.html
# >> 
# >> * (2014-02-21 00:00:00 +0900最強の布陣で挑む！ GA文庫電子版【俺TUEEEEE】キャンペーン開催中
# >>      http://www.sbcr.jp/topics/11719/
# >> * (2014-02-20 00:00:00 +0900【新刊情報】2014年2月17日～23日　「コンセプト」の作り方がわかるビジネス書など12点
# >>      http://www.sbcr.jp/topics/11712/
# >> * (2014-02-14 00:00:00 +0900『数学ガール』電子書籍版がAmazon Kindleで配信開始！ キャンペーンも同時開催！！
# >>      http://www.sbcr.jp/topics/11710/
# >> * (2014-02-12 00:00:00 +0900【新刊情報】2014年2月10日～16日　アニメ化決定『ワルブレ』最新刊など11点
# >>      http://www.sbcr.jp/topics/11703/
# >> * (2014-02-06 00:00:00 +0900【新刊情報】2014年2月1日～9日　GA文庫・イラストレーターの画集2点が発売
# >>      http://www.sbcr.jp/topics/11684/
# >> * (2014-01-27 00:00:00 +0900【新刊情報】2014年1月27日～31日　PC/IT書の新刊4点が発売
# >>      http://www.sbcr.jp/topics/11660/
# >> * (2014-01-23 00:00:00 +0900【新刊情報】2014年1月20日～26日　全米で話題騒然のビジネス書『ワン・シング』など3点が発売
# >>      http://www.sbcr.jp/topics/11657/
# >> * (2014-01-20 00:00:00 +09001月25日14時～　『のうりん』サイン会＠みどり書房・桑野店のお知らせ
# >>      http://www.sbcr.jp/topics/11626/
# >> * (2014-01-16 00:00:00 +0900【新刊情報】2014年1月16日～19日　『大聖堂』のケン・フォレット 最新作・刊行開始！
# >>      http://www.sbcr.jp/topics/11613/
# >> * (2014-01-09 00:00:00 +0900『のうりん』TVアニメ放送開始直前 電子書籍スペシャルキャンペーン本日開幕！
# >>      http://www.sbcr.jp/topics/11612/
# >> * (2014-01-09 00:00:00 +0900【新刊情報】2014年1月1日～15日　TVアニメ原作『のうりん』最新巻を始め10点が刊行
# >>      http://www.sbcr.jp/topics/11607/
# >> * (2013-12-27 00:00:00 +0900SB新書 電子版5カ月連続【半額キャンペーン】いよいよフィナーレ
# >>      http://www.sbcr.jp/topics/11602/
# >> * (2013-12-27 00:00:00 +0900【新刊情報】2013年12月23日～31日　『スーパーダンガンロンパ2』コミック第2巻など4点
# >>      http://www.sbcr.jp/topics/11598/
# >> * (2013-12-26 00:00:00 +0900GA文庫×スクウェア・エニックス　年末年始の電子書籍大コラボキャンペーン　第一弾始動！
# >>      http://www.sbcr.jp/topics/11601/
# >> * (2013-12-19 00:00:00 +0900【お知らせ】年末年始のお問い合わせ対応に関しまして
# >>      http://www.sbcr.jp/topics/11592/
# >> * (2013-12-18 00:00:00 +0900【新刊情報】2013年12月16日～22日　五輪招致のプレゼンを分析したSB新書など10点
# >>      http://www.sbcr.jp/topics/11590/
# >> * (2013-12-13 00:00:00 +0900【電子書籍】GA文庫「完結シリーズ」全巻お買い得キャンペーン
# >>      http://www.sbcr.jp/topics/11586/
# >> * (2013-12-12 00:00:00 +0900【新刊情報】2013年12月9日～15日　『本当に頭がよくなる1分間記憶法』など9点が刊行
# >>      http://www.sbcr.jp/topics/11585/
# >> * (2013-12-05 00:00:00 +0900【新刊情報】2013年12月1日～8日　『仕事に役立つExcelビジネスデータ分析』など3点が刊行
# >>      http://www.sbcr.jp/topics/11551/
# >> * (2013-11-29 00:00:00 +0900【電子書籍】やったね！お兄ちゃん！「妹！大集合キャンペーン！」
# >>      http://www.sbcr.jp/topics/11549/
# >> * (2013-11-28 00:00:00 +0900【新刊情報】2013年11月25日～30日　予約が取れない料理教室のレシピ本など8点が刊行
# >>      http://www.sbcr.jp/topics/11544/
# >> * (2013-11-22 00:00:00 +0900SB新書 電子版 【半額キャンペーン】第四弾開催中
# >>      http://www.sbcr.jp/topics/11541/
# >> * (2013-11-21 00:00:00 +0900『jQuery最高の教科書』発売記念、株式会社シフトブレインWeb制作セミナー
# >>      http://www.sbcr.jp/topics/11532/
# >> * (2013-11-20 00:00:00 +0900【新刊情報】2013年11月18日～24日　『親子でつくるエンディングノート』ほか全7タイトルが刊行
# >>      http://www.sbcr.jp/topics/11509/
# >> * (2013-11-15 00:00:00 +0900【電子書籍】「神曲奏界ポリフォニカ クリムゾンシリーズ」完結記念！　1巻～5巻が特別価格！
# >>      http://www.sbcr.jp/topics/11505/
# >> * (2013-11-15 00:00:00 +0900【新刊情報】2013年11月11日～17日　iPad Air対応の『スタートブック』、文庫・新書など13点
# >>      http://www.sbcr.jp/topics/11499/
# >> * (2013-11-11 00:00:00 +0900テレビ朝日「ビートたけしのTVタックル」出演・新見正則さんの著書『長生きしたけりゃデブがいい』はこちら
# >>      http://www.sbcr.jp/products/4797374858.html
# >> * (2013-11-07 00:00:00 +0900【新刊情報】2013年11月5日～10日　サイエンス・アイ新書『質量とヒッグス粒子』が発売
# >>      http://www.sbcr.jp/topics/11478/
# >> * (2013-11-01 00:00:00 +0900『落第騎士の英雄譚<キャバルリィ>』電子書籍版配信記念！　海空りく特集！
# >>      http://www.sbcr.jp/topics/11476/
# >> * (2013-10-28 00:00:00 +0900SB新書　電子版　【半額キャンペーン】第三弾開催中
# >>      http://www.sbcr.jp/topics/11471/
# >> * (2013-10-24 00:00:00 +0900【新刊情報】2013年10月21日～27日　『朝さつまいもダイエット』『LINE PLAY 公式活用ガイド』など
# >>      http://www.sbcr.jp/topics/11464/
# >> * (2013-10-21 00:00:00 +0900GA文庫から珠玉の名作を織り交ぜた電子書籍キャンペーンをお送りします
# >>      http://www.sbcr.jp/topics/11463/
# >> * (2013-10-17 00:00:00 +0900【新刊情報】2013年10月15日～20日<br>文庫・新書などが一挙19冊発売！
# >>      http://www.sbcr.jp/topics/11446/
# >> * (2013-10-15 00:00:00 +0900『LINE PLAY 公式活用ガイド』電子版　先行配信＆半額キャンペーン
# >>      http://www.sbcr.jp/topics/11443/
# >> * (2013-10-15 00:00:00 +0900学校採用・企業採用向け【Book Selection 2013-14 Winter】ができました！
# >>      http://www.sbcr.jp/topics/11444/
# >> * (2013-10-09 00:00:00 +0900映画『セイフ ヘイヴン』原作本　先行販売のお知らせ
# >>      http://www.sbcr.jp/topics/11441/
# >> * (2013-10-04 00:00:00 +0900【新刊情報】2013年10月1日～6日<br>iPhone 5s/5c関連本4冊が発売
# >>      http://www.sbcr.jp/topics/11368/
# >> * (2013-10-01 00:00:00 +0900社名変更、および書籍のシリーズ名の変更について
# >>      http://www.sbcr.jp/topics/11432/
# >> * (2013-09-19 00:00:00 +0900『ゲームはこうしてできている』刊行記念　岸本 好弘氏　特別授業＆サイン会を開催
# >>      http://www.sbcr.jp/topics/11395/
# >> * (2013-09-12 00:00:00 +0900TVアニメ化決定で絶好調の『のうりん』　待望の電子書籍1～5巻を一挙に配信開始！
# >>      http://www.sbcr.jp/topics/11397/
# >> * (2013-09-06 00:00:00 +0900GA文庫「おと×まほ」電子書籍キャンペーン第三弾 開催中！
# >>      http://www.sbcr.jp/topics/11394/
# >> * (2013-09-03 00:00:00 +0900『親に何かあっても心配ない遺言の話』出版記念特別無料セミナーを開催
# >>      http://www.sbcr.jp/souzoku/" target="_blank
# >> * (2013-08-23 00:00:00 +0900ソフトバンク新書　電子版5か月連続半額キャンペーン第一弾　各電子書店にて実施中！
# >>      http://www.sbcr.jp/topics/11371/
# >> * (2013-08-23 00:00:00 +0900ヴァリアブル・アクセル配信記念！　七条剛キャンペーン実施中！！
# >>      http://www.sbcr.jp/topics/11372/
# >> * (2013-08-10 00:00:00 +0900『プロが教えるWebマーケティング&集客・販促【完全ガイドブック】』 著者・福山大樹 トーク&サイン会
# >>      http://www.sbcr.jp/topics/11335/
# >> * (2013-08-01 00:00:00 +0900GA文庫「おと×まほ」電子書籍キャンペーン第二弾 開催中！
# >>      http://www.sbcr.jp/topics/11332/
# >> * (2013-08-01 00:00:00 +0900【祝】『ゲームを動かす技術と発想』『ゲームの作り方』がCEDEC AWARDSの著述賞をW受賞
# >>      http://www.sbcr.jp/topics/11330/
# >> * (2013-07-29 00:00:00 +0900感動のベストセラー『ディズニーの神様シリーズ』電子書籍　夏休み特別価格で配信！
# >>      http://www.sbcr.jp/topics/11320/
# >> * (2013-07-16 00:00:00 +0900「BOOK EXPRESS」ＧＡ文庫　超レア！限定コラボエコバック　プレゼント中！
# >>      http://www.sbcr.jp/topics/11294/
# >> * (2013-07-16 00:00:00 +0900『12年目のパリ暮らし』刊行記念　中村江里子さんサイン会開催決定！
# >>      http://www.sbcr.jp/topics/11291/
# >> * (2013-07-05 00:00:00 +0900GA文庫「おと×まほ」電子書籍キャンペーン 開催中！
# >>      http://www.sbcr.jp/topics/11288/
# >> * (2013-06-28 00:00:00 +0900【祝】CPU大賞受賞！『本格ビジネスサイトを作りながら学ぶ WordPressの教科書』
# >>      http://www.sbcr.jp/topics/11279/
# >> * (2013-06-21 00:00:00 +0900GA文庫「サスペンス&ミステリー」電子書籍キャンペーン
# >>      http://www.sbcr.jp/topics/11271/
# >> * (2013-06-16 00:00:00 +0900『なりたいボディになる！奇跡のKAWASAKIメソッド』刊行記念　当社特別枠限定優待・プレゼント実施中！
# >>      http://www.sbcr.jp/topics/11245/
# >> * (2013-06-13 00:00:00 +0900学校採用・企業採用向け【Book Selection 2013 Summer】ができました！
# >>      http://www.sbcr.jp/topics/11247/
# >> * (2013-06-12 00:00:00 +0900『モテの定理』TSUTAYAオンラインキャンペーン実施中！
# >>      http://www.sbcr.jp/topics/11249/
# >> * (2013-05-23 00:00:00 +0900GA文庫『魔法の材料ございます』電子書籍版、キャンペーンセール開催中！
# >>      http://www.sbcr.jp/topics/11218/
# >> * (2013-05-10 00:00:00 +0900『ユーザ中心ウェブビジネス戦略』の出版記念セミナー開催決定！
# >>      http://www.sbcr.jp/topics/11193/
# >> * (2013-04-26 00:00:00 +0900「第4回GA文庫大賞受賞作」電子書籍キャンペーン実施中！
# >>      http://www.sbcr.jp/topics/11184/
# >> * (2013-04-03 00:00:00 +0900『ディズニー ありがとうの神様が教えてくれたこと』4月4日（木）より順次、先行販売！
# >>      http://www.sbcr.jp/topics/11128/
# >> * (2013-04-02 00:00:00 +0900『ディズニー ありがとうの神様が教えてくれたこと』刊行記念　著者・鎌田 洋　講演会＆サイン会開催決定！
# >>      http://www.sbcr.jp/topics/11127/
# >> * (2013-03-30 00:00:00 +0900ニャル子Ｗ＆俺修羅アニメ連動キャンペーン実施中！
# >>      http://www.sbcr.jp/topics/11124/
# >> * (2013-02-21 00:00:00 +0900『ゲームの作り方』(加藤 政樹 著)先行販売！
# >>      http://www.sbcr.jp/topics/11032/
# >> * (2013-02-12 00:00:00 +0900『のうりん』著者、白鳥士郎さん講演「ラノベのすゝめ講演会」開催決定！−受付終了しました。
# >>      http://www.sbcr.jp/topics/11015/
# >> * (2013-01-30 00:00:00 +0900サイエンス・アイ新書Kindle版 第1弾26タイトルリリースしました！
# >>      http://sciencei.sbcr.jp/archives/2013/01/kindle126.html
# >> * (2013-01-29 00:00:00 +0900『ビッグデータ時代の新マーケティング思考』出版記念セミナー開催！※UST、ニコ生で試聴可能
# >>      http://www.sbcr.jp/topics/10960/
# >> * (2012-12-20 00:00:00 +0900写真家・菅原一剛が10年間撮り続けた"空の記憶"書籍＆iPhone/iPadアプリ「今日の空」を発売
# >>      http://www.softbankcr.co.jp/ja/news/press/2012/1220_002435/
# >> * (2012-12-14 00:00:00 +0900GA文庫フェア　ブックエキスプレス エキュート上野店にて開催！
# >>      http://www.sbcr.jp/topics/10948/
