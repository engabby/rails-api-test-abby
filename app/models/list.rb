# app/models/list.rb
class List < ApplicationRecord
  # model association
  has_many :cards, dependent: :destroy
  has_and_belongs_to_many :users

  # validations
  validates_presence_of :title, :created_by
end
