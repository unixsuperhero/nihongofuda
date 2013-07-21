class FudaYamafuda < ActiveRecord::Base
  self.table_name = 'fuda_yamafuda'

  belongs_to :fuda
  belongs_to :yamafuda

  def self.yamafuda_ids
    select('distinct yamafuda_id').map(&:yamafuda_id)
  end
end
