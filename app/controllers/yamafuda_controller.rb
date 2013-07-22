class YamafudaController < ApplicationController
  before_action :track_random_url, only: :random

  expose(:fuda) { yamafuda.fuda.find_by(id: params[:id]) }
  expose(:yamafuda) { Yamafuda.find_by(name: params[:name]) || Yamafuda.usable.order('random()').first }
  expose(:random_card) { yamafuda && Fuda.where(id: yamafuda.fuda_ids).order('random()').first }

  private

  def track_random_url
    cookies[:random_url] = params[:name].present? && yamafuda_random_url(params[:name]) || random_url
  end
end
