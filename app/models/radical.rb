class Radical < ActiveRecord::Base
  has_many :kanji_radicals
  has_many :kanji, through: :kanji_radicals
end
