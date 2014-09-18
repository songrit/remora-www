class Trade

  include Mongoid::Document

  field :trade_on, type: Date
  field :ins_buy, type: Float
  field :ins_sell, type: Float
  field :fin_buy, type: Float
  field :fin_sell, type: Float
  field :for_buy, type: Float
  field :for_sell, type: Float
  field :ret_buy, type: Float
  field :ret_sell, type: Float
  field :set_index, type: Float
  field :created_at, type: Time

  def self.test_string
    self.new.string2f('1,234')
  end
  def self.get_data
    require 'open-uri'
    url = "http://marketdata.set.or.th/mkt/investortype.do?language=th&country=TH"
    doc = Nokogiri::HTML(open(url).read)
    num = []
    tran_date = doc.css('strong')[1].text
    tran_on = tran_date[/[0-9]+.+[0-9]+/]
    data = doc.at_css('.background')
    data.css('td[align="right"]').each do |v|
      vs = v.text[/[\-0-9,\.]+/]
      num << self.new.string2f(vs)
    end
    url = "http://marketdata.set.or.th/mkt/marketsummary.do?language=th&country=TH"
    set_index = self.new.string2f(doc.css('tr:nth-child(8) td')[1].text)
    doc = Nokogiri::HTML(open(url).read)
    trade = Trade.create :trade_on=> self.new.date_thai2date(tran_on),
      :ins_buy => num[0], :ins_sell => num[2],
      :fin_buy => num[6], :fin_sell => num[8],
      :for_buy => num[12], :for_sell => num[14],
      :ret_buy => num[18], :ret_sell => num[20],
      :set_index => set_index, :created_at => Time.now
  end

  # private
  def string2f(s)
    s.gsub(',','').to_f
  end
  def date_thai2date(s)
    # s in format 17 ก.ย. 2557
    mh = {'ม.ค.'=>1, 'ก.พ.'=>2, 'มี.ค.'=>3, 'เม.ย.'=>4, 'พ.ค.'=>5, 'มิ.ย.'=>6,
      'ก.ค.'=>7, 'ส.ค.'=>8, 'ก.ย.'=>9, 'ต.ค.'=>10, 'พ.ย.'=>11, 'ธ.ค.'=>12}
    ss= s.split(' ')
    month = mh[ss[1]]
    year = ss[2].to_i-543
    Date.new(year,month,ss[0].to_i)
  end

end
