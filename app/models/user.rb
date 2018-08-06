#class User < ApplicationRecord
#end

# app/models/user.rb
class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :lists, foreign_key: :created_by
  has_many :cards, through: :lists
  # Validations
  validates_presence_of :username, :email, :password_digest
end
