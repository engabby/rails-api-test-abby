class AddListRefToMemberships < ActiveRecord::Migration[5.2]
  def change
    add_reference :memberships, :list, foreign_key: true
  end
end
