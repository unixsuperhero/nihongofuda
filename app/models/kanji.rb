class Kanji < ActiveRecord::Base
  self.table_name = 'kanji'

  has_many :fuda_kanji
  has_many :fuda, through: :fuda_kanji

  attr_accessor :kun_arr, :on_arr, :meaning_arr
end
