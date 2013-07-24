class Jisho
  extend URI::Escape

  attr_accessor :response
  attr_accessor :words

  def self.search(q, pg=1)
    @response = HTTParty.get(['http://iphone.jisho.org/words/?', 'dict=edict&jap=', encode(q), '&page=', pg].join)
    Jisho.new(@response)
  end

  def self.find(q, pg=1)
    @response = HTTParty.get(['http://iphone.jisho.org/words/?', 'dict=edict&jap=', encode(q), '&page=', pg].join)
    (@response['words'] || []).keep_if{|w| w['key'] == q }.map{|w| Word.new(w) }
  end

  def initialize(opts)
    @response = opts
  end

  def words
    @words ||= @response['words'] || []
  end

  class Word
    include ActionView::Helpers::SanitizeHelper
    attr_accessor :literal, :kana, :meanings

    def initialize(opts)
      @literal = opts['key']
      @kana = opts['kana']
      @meanings = strip_tags opts['meanings'].join("\n")
    end
  end
end
