class Comment < ApplicationRecord
  belongs_to :card , counter_cache: true
  belongs_to :parent,  class_name: 'Comment'  , optional: true#-> requires "parent_id" column
  has_many   :replies, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy

  before_save :cache_counters

  #def after_save
  #  self.update_counter_cache
  #end

  #def after_destroy
  #  self.update_counter_cache
  #end

  #def update_counter_cache
  #  new_count = Comment.where(:card_id => self.card.id).where(:parent_id => [nil, ""]).size
  #  Card.update_counters(self.card.id, comments_count: new_count)
  #end

  private
  def cache_counters
    self.card.comments_count = Comment.where(:card_id => self.card.id).where(:parent_id => [nil, ""]).size
  end
end
