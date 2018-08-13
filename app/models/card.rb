#class Card < ApplicationRecord
#  belongs_to :list
#end

# app/models/card.rb
class Card < ApplicationRecord
  scope :featured, -> { order('jobs_count DESC') }
  # model association
  belongs_to :list
  belongs_to :user
  has_many :comments, dependent: :destroy

  # validation
  validates_presence_of :title, :description
end
