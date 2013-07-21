class Yamafuda < ActiveRecord::Base
  self.table_name = 'yamafuda'

  has_many :fuda_yamafuda
  has_many :fuda, through: :fuda_yamafuda

  scope :usable, -> { where(id: FudaYamafuda.yamafuda_ids) }
end