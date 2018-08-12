#class User < ApplicationRecord
#end

# app/models/user.rb
class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  #has_many :lists, foreign_key: :created_by
  #, foreign_key: :created_by
  has_many :memberships
  has_many :lists, through: :memberships
  has_many :cards , dependent: :destroy
  # Validations
  validates_presence_of :username, :email, :password_digest

  # This method gives us a simple call to check if a user has permission to modify.
  def can_modify_user?(user_id)
    is_admin == true || id.to_s == user_id.to_s
  end

  # This method tells us if the user is an admin or not.
  def is_admin?
    is_admin == true
  end

  def is_member?(list_id)
    lists.exists?(list_id)
  end
end
