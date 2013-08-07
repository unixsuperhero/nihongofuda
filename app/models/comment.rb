class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true

  # self join: replies
  belongs_to :parent, class_name: 'Comment'
  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id'
end
