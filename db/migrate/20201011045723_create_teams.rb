class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :image
      t.string :join_key, null: false

      t.timestamps
    end
  end
end
