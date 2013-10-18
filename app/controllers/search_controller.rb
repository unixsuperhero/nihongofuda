class SearchController < ApplicationController
  expose(:query) { params[:q] }
  expose(:kana) { Romaji.to_kana(query) }
  expose(:results) {
    if kana.scan(/./).all?{|k| Kana.all.include?(k) }
      Edict.where("reading like '#{kana}%'").order('length(reading),literal')
    else
      Edict.where("literal like '#{kana}%'").order('length(reading),literal')
    end
  }

  expose(:compounds) {
    if kana.scan(/./).all?{|k| Kana.all.include?(k) }
      []
    else
      Edict.where("literal like '%#{kana}%'").order('length(literal),length(reading)')
    end
  }

end
