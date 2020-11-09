class AddLoginnameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :longinname, :string, :unique => true, :null => false
  end
end
