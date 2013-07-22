class YamafudaYamafuda < ActiveRecord::Base
  belongs_to :yamafuda
  belongs_to :child_yamafuda, class_name: 'Yamafuda'
end
