class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :list

  validates_uniqueness_of :list_id, :scope => [:user_id]
end
