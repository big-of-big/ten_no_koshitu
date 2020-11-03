class RemoveUserIdFromTenhouAccounts < ActiveRecord::Migration[6.0]
  def change
    remove_column :tenhou_accounts, :user_id, :integer
  end
end
