class KanjiController < ApplicationController
  expose(:kanji) { Kanji.relevant.stroke }
end
