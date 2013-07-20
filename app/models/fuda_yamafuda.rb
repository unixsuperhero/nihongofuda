class FudaYamafuda < ActiveRecord::Base
  self.table_name = 'fuda_yamafuda'
  belongs_to :fuda
  belongs_to :yamafuda
end
