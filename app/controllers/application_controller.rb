class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  expose(:all_yamafuda) { Yamafuda.usable }
  expose(:basic_decks) { Yamafuda.where(name: %w{hiragana katakana}) }
  expose(:kanji_decks) { Yamafuda.where("name ~ 'kanji.*[0-9]$'") }
  expose(:kanji_kun_decks) { Yamafuda.where("name ~ 'kanji.*[0-9] kun-only$'") }
  expose(:kanji_meaning_decks) { Yamafuda.where("name ~ 'kanji.*[0-9] meanings$'") }
  expose(:srs_decks) { Yamafuda.where("name ~ 'Day '") }
  expose(:your_decks) { Yamafuda.where(user_id: current_user && current_user.id) }
end
