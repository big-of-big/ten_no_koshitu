class RemoveColumnsFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :tenhou_account, :string
    remove_column :users, :image, :string
  end
end
