class FudaKanji < ActiveRecord::Base
  self.table_name = 'fuda_kanji'

  belongs_to :fuda
  belongs_to :kanji
end
