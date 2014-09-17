
class KorakotController < ApplicationController
  def test
    # require 'open-uri'
    # url = "http://marketdata.set.or.th/mkt/investortype.do?language=th&country=TH"
    # f = open()
# file = File.open('tmp/sample.html','w') do |f|
#   f.binmode
#   f << open(url).read
# end
file_name= 'tmp/sample.html'
# f = File.open(file_name).read
    f = File.read(file_name)
    doc = Nokogiri::HTML(f)
    # doc = Nokogiri::HTML(f, nil, 'windows-874')
    num = []
    bg = doc.at_css('.background')
    bg.css('td[align="right"]').each do |v|
      vs = v.text[/[\-0-9,\.]+/]
      num << vs.gsub(',','').to_f
    end
    render :text=> num
    # render :text=> doc.at_css('.background table table table table table').text
  end
end
