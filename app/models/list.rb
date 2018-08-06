# app/models/list.rb
class List < ApplicationRecord
  # model association
  has_many :cards, dependent: :destroy

  # validations
  validates_presence_of :title, :created_by
end
