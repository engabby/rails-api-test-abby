# app/models/list.rb
class List < ApplicationRecord
  # model association
  has_many :cards, dependent: :destroy
  has_many :memberships
  has_many :users, through: :memberships

  # validations
  validates_presence_of :title, :created_by
end
