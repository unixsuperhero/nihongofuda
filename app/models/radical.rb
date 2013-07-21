class Radical < ActiveRecord::Base
  belongs_to :original_kanji, class_name: 'Kanji'

  has_many :kanji_radicals
  has_many :kanji, through: :kanji_radicals
end
