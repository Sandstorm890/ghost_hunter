class DropToolsTable < ActiveRecord::Migration
  def change
    drop_table :tools
  end
end
