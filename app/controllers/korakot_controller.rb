class KorakotController < ApplicationController
  require 'open-uri'

  def get_data
    url = "http://marketdata.set.or.th/mkt/investortype.do?language=th&country=TH"
    doc = Nokogiri::HTML(open(url).read)
    num = []
    tran_date = doc.css('strong')[1].text
    tran_on = tran_date[/[0-9]+.+[0-9]+/]
    data = doc.at_css('.background')
    data.css('td[align="right"]').each do |v|
      vs = v.text[/[\-0-9,\.]+/]
      num << string2f(vs)
    end
    url = "http://marketdata.set.or.th/mkt/marketsummary.do?language=th&country=TH"
    doc = Nokogiri::HTML(open(url).read)
    set_index = string2f(doc.css('tr:nth-child(8) td')[1].text)
    trade = Trade.create :trade_on=> date_thai2date(tran_on),
      :ins_buy => num[0], :ins_sell => num[2],
      :fin_buy => num[6], :fin_sell => num[8],
      :for_buy => num[12], :for_sell => num[14],
      :ret_buy => num[18], :ret_sell => num[20],
      :set_index => set_index
    render :json=> trade.to_yaml
  end

  # use for testing - get html from web and save to local file
  # to test Nokogiri parsing
  def get_index
    # url = "http://marketdata.set.or.th/mkt/marketsummary.do?language=th&country=TH"
    # file = File.open('tmp/sample_index.html','w') do |f|
    #   f.binmode
    #   f << open(url).read
    # end
    file_name= 'tmp/sample_index.html'
    f = File.read(file_name)
    doc = Nokogiri::HTML(f)
    set_index = doc.css('tr:nth-child(8) td')[1].text
    render :text => string2f(set_index)
  end

  private
  def string2f(s)
    s.gsub(',','').to_f
  end
  def date_thai2date(s)
    # s in format 17 ก.ย. 2557
    mh = {'ก.ย.'=>9}
    ss= s.split(' ')
    month = mh[ss[1]]
    year = ss[2].to_i-543
    Date.new(year,month,ss[0].to_i)
  end
end
