class Fuda < ActiveRecord::Base
  self.table_name = 'fuda'
  has_many :fuda_yamafuda
  has_many :yamafuda, through: :fuda_yamafuda

  has_many :fuda_kanji
  has_many :kanji, through: :fuda_kanji
end
