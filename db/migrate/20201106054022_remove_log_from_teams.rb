class RemoveLogFromTeams < ActiveRecord::Migration[6.0]
  def change
    remove_column :teams, :log, :text
  end
end
