class KorakotController < ApplicationController
  def report
    @trades = Trade.all.desc(:created_at)
  end
  def get_data
    # url = "http://marketdata.set.or.th/mkt/investortype.do?language=th&country=TH"
    # doc = Nokogiri::HTML(open(url).read)
    # num = []
    # tran_date = doc.css('strong')[1].text
    # tran_on = tran_date[/[0-9]+.+[0-9]+/]
    # data = doc.at_css('.background')
    # data.css('td[align="right"]').each do |v|
    #   vs = v.text[/[\-0-9,\.]+/]
    #   num << string2f(vs)
    # end
    # url = "http://marketdata.set.or.th/mkt/marketsummary.do?language=th&country=TH"
    # doc = Nokogiri::HTML(open(url).read)
    # set_index = string2f(doc.css('tr:nth-child(8) td')[1].text)
    # trade = Trade.test_string
    trade = Trade.get_data
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

end
