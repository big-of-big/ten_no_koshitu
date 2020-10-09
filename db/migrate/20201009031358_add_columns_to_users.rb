class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :tenhou_account, :string
    add_column :users, :image, :string
    add_column :users, :team_id, :integer
  end
end
