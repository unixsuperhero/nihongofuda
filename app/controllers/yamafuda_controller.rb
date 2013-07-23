class YamafudaController < ApplicationController
  before_action :track_random_url, only: :random

  expose(:page) { (params[:page] || 1).to_i }
  expose(:page_offset) { (page - 1) * 10 }
  expose(:yamafuda) { Yamafuda.find_by(name: params[:name]) }
  expose(:fuda_page) { yamafuda.all_fuda.limit(10).offset(page_offset) }

  expose(:random_yamafuda) { yamafuda || Yamafuda.usable.order('random()').first }
  expose(:random_card) { random_yamafuda && Fuda.where(id: random_yamafuda.fuda_ids).order('random()').first }

  expose(:fuda) { yamafuda.fuda.find_by(id: params[:id]) }

  def show
    render layout: nil and return if request.xhr?
  end

  private

  def track_random_url
    cookies[:random_url] = params[:name].present? && yamafuda_random_url(params[:name]) || random_url
  end
end
