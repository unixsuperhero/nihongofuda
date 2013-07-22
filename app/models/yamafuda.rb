class Yamafuda < ActiveRecord::Base
  self.table_name = 'yamafuda'

  has_many :parent_decks, class_name: 'YamafudaYamafuda', foreign_key: :child_yamafuda_id
  has_many :parents, through: :parent_decks, source: :yamafuda

  has_many :yamafuda_yamafuda
  has_many :children, through: :yamafuda_yamafuda, source: :child_yamafuda

  has_many :fuda_yamafuda
  has_many :fuda, through: :fuda_yamafuda

  scope :usable, -> { where(id: FudaYamafuda.yamafuda_ids) }

  def fuda_ids
    ids = children.flat_map{|y| y.fuda_ids }
    FudaYamafuda.where(yamafuda_id: self.id).map(&:fuda_id) + ids
  end

  def all_fuda
    Fuda.where(id: fuda_ids)
  end
end
