class AddDescriptionAndGhostTypeToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :ghost_type, :string
    add_column :jobs, :description, :text
  end
end
