class Fuda < ActiveRecord::Base
  has_many :fuda_yamafuda
  has_many :yamafuda, through: :fuda_yamafuda
end
