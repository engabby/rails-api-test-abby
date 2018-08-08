class ListsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :lists_users, id: false do |t|
      t.belongs_to :list, index: true
      t.belongs_to :user, index: true
    end
  end
end
