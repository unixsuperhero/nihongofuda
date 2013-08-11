class Kanji < ActiveRecord::Base
  self.table_name = 'kanji'

  has_many :fuda_kanji
  has_many :fuda, through: :fuda_kanji

  has_many :kanji_radicals
  has_many :radicals, through: :kanji_radicals

  attr_accessor :kun_arr, :on_arr, :meaning_arr

  scope :relevant, -> { where(grade: [*1..8]) }
  scope :stroke, -> { order(:strokes,:grade,:frequency) }
  scope :grade, -> { order(:grade,:strokes,:frequency) }

  scope :with_okuri, -> { where("kun ~ '[.]'") }
  scope :kuns, -> { where("kun ~ ','") }
  scope :ons, -> { where("on ~ ','") }

  def kun_readings
    Reading.load_kun self
  end

  def on_readings
    Reading.load_on self
  end

  def okurigana
    Reading.get_okurigana(kun)
  end

  def okurigana_literals
    okurigana.map do |okuri|
      Reading.okurigana(literal, okuri)
    end
  end

  def rubify literal, furi
    "<ruby>#{literal}<rt>#{furi}</rt></ruby>"
  end

  def okurigana_furigana
    ['',okurigana].flatten.map do |okuri|
      okuri =~ /^([^.]*)[.]/
      okuri.sub(/^([^.]*)[.]/, rubify(literal, $1))
    end
  end

  def all_okurigana
    Edict.where(literal: okurigana_literals)
  end

  def frequency_percentage
    sprintf("%.2f", frequency.to_f / 2501 * 100)
  end
end
