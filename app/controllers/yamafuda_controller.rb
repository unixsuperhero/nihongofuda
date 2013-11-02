class YamafudaController < ApplicationController
  before_action :track_quiz_url, only: :quiz

  expose(:page) { (params[:page] || 1).to_i }
  expose(:page_offset) { (page - 1) * 10 }
  expose(:yamafuda) { Yamafuda.find_by(name: params[:name]) }
  expose(:fuda_page) { yamafuda.fuda.order(:id).limit(10).offset(page_offset) }
  expose(:fuda_count) { yamafuda.fuda.count }

  expose(:random_yamafuda) { yamafuda || Yamafuda.usable.order('random()').first }
  expose(:random_card) { random_yamafuda && Fuda.where(id: random_yamafuda.fuda_ids).order('random()').first }

  expose(:fuda) { yamafuda.fuda.find_by(id: params[:id]) }

  def board
    render_next_page if params.has_key?(:continuous)
  end

  def study_board
    render_next_page if params.has_key?(:continuous)
  end

  def continuous_show
    render_next_page
  end

  private

  def render_next_page
    render json: {
      current_page: page,
      last_page: (page * 10) >= fuda_count,
      content: render_to_string(layout: nil) || ''
    }
  end

  def track_quiz_url
    cookies[:quiz_url] = params[:name].present? && quiz_url(params[:name]) || any_quiz_url
  end
end
