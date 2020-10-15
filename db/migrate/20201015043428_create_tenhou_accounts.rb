class CreateTenhouAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :tenhou_accounts do |t|
      t.string :name, null: false
      t.integer :team_id

      t.timestamps

    end

    add_index :tenhou_accounts, [:name, :team_id], unique: true
  end
end
