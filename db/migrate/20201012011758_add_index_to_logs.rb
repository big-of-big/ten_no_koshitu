class AddIndexToLogs < ActiveRecord::Migration[6.0]
  def change
    add_index :logs, :name, unique: true
  end
end
