class KorakotController < ApplicationController
  def report
    @trades = Trade.all.desc(:created_at)
  end
  def get_data
    trade = Trade.get_data
    # render :json=> trade.to_yaml
    redirect_to action: 'report'
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
