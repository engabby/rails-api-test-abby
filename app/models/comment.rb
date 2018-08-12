class Comment < ApplicationRecord
  belongs_to :parent_comment, :class_name => 'Comment'
  has_many :reply, :class_name => 'Comment', :foreign_key => 'parent_comment_id'
end
