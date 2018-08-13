class AddCardIdColToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :card_id, :integer, index: true
  end
end
