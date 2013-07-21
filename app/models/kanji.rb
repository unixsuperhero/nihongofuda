class Kanji < ActiveRecord::Base
  self.table_name = 'kanji'
  #attr_accessor :literal
  #attr_accessor :radicals, :skip
  #attr_accessor :kun, :on, :meanings
  #attr_accessor :frequency, :grade

  attr_accessor :kun_arr, :on_arr, :meaning_arr
end
