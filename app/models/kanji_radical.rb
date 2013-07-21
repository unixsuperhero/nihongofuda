class KanjiRadical < ActiveRecord::Base
  belongs_to :kanji
  belongs_to :radical
end
