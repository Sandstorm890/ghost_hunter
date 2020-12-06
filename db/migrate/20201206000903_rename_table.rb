class RenameTable < ActiveRecord::Migration
  def change
    rename_table :hunters, :users
  end
end
