class AddLoginnameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :loginname, :string, :unique => true, :null => false
  end
end
