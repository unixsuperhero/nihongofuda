class KanjiController < ApplicationController
  expose(:kanji) { Kanji.find_by(literal: params[:literal]) }
  expose(:okurigana) { kanji.all_okurigana }
  expose(:kanji_by_stroke) { Kanji.relevant.stroke }
end
