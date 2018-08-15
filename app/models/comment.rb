class Comment < ApplicationRecord
  belongs_to :card
  belongs_to :parent,  class_name: 'Comment'  , optional: true#-> requires "parent_id" column
  has_many   :replies, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy

  counter_cache_with_conditions :card, :comments_count, [:parent_id], lambda{|parent_id| parent_id == nil}

end
