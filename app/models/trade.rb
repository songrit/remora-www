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
end
