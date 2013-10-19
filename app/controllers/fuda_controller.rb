class FudaController < ApplicationController
  expose(:edict) { Edict.find(params[:edict_id]) }
  expose(:front_text) { edict.literal }
  expose(:back_text) { [edict.reading, edict.meanings].join("\n--------\n") }
  expose(:similar) { Edict.where("literal like '%#{edict.literal}%'") }

  expose(:kanji) {
    edict.literal.scan(/./).map{|char| Kanji.find_by(literal: char) }.compact
  }

  expose(:yamafuda) { Yamafuda.find_or_create_by(name: params[:yamafuda_name], user_id: current_user.id) }
  expose(:fuda) { Fuda.new(front: front_text, back: back_text) }
  expose(:new_fuda) { Fuda.new(fuda_attrs) }
  expose(:fuda_attrs) {
    params.require(:fuda).permit(
      :front, :back, :user_id
    ).merge(user_id: current_user.id)
  }

  def create
    new_fuda.save
    yamafuda.fuda << new_fuda
  end
end
