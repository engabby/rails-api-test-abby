class AddCommentsCountColToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :comments_count, :integer, default: 0
  end
end
