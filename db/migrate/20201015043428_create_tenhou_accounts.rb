class CreateTenhouAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :tenhou_accounts do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
