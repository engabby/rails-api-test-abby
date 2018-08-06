#class Card < ApplicationRecord
#  belongs_to :list
#end

# app/models/card.rb
class Card < ApplicationRecord
  # model association
  belongs_to :list

  # validation
  validates_presence_of :title, :description
end
