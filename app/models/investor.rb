class Investor
  include Mongoid::Document
  field :name_en, type: String
  field :name_th, type: String
end
