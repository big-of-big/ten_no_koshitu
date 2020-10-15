class CreateTeamLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :team_logs do |t|
      t.string :name
      t.integer :team_id
      t.text :content

      t.timestamps
    end

    add_index :team_logs, [:name, :team_id], unique: true
  end
end
