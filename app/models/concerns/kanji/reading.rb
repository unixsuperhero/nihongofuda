class Kanji::Reading

  class << self
    def furigana(literal,text)
      text.sub(/^([^.-]*)[.-]?/, "<ruby>#{literal}<rt>\\1</rt></ruby>")
    end

    def okurigana(literal,text)
      text.sub(/^([^.]*)[.]/, literal)
    end

    def get_okurigana(text)
      Array(text.split(/,/)).keep_if{|t| t =~ /[.]/ }
    end
  end

  ########################
  ## INSTANCE METHODS etc.
  ########################

  attr_accessor :kanji, :literal

  def initialize(kan, text)
    @kanji = kan
    @literal = text
  end

  def furigana
    Format.new(self).furigana
  end

  def self.load_on  kanji; load_by_attribute(kanji,  :on); end
  def self.load_kun kanji; load_by_attribute(kanji, :kun); end

  def self.load_by_attribute(kanji, attr)
    return [] unless kanji.respond_to? attr
    kanji.send(attr).split(/\s*,\s*/).map do |reading|
      new(kanji, reading)
    end
  end

  class Format
    attr_accessor :reading
    def initialize(text)
      @reading = text
    end

    def literal
      reading.literal.sub(/^([^.-]*)[.-]?/, reading.kanji.literal)
    end

    def furigana
      reading.literal.sub(/^([^.-]*)[.-]?/, "<ruby>#{reading.kanji.literal}<rt>\\1</rt></ruby>")
    end
  end
end
