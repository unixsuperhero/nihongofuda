class Yamafuda < ActiveRecord::Base
  has_many :fuda_yamafuda
  has_many :fuda, through: :fuda_yamafuda
end
