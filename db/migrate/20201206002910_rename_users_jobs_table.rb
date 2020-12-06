class RenameUsersJobsTable < ActiveRecord::Migration
  def change
    rename_table :users_jobs, :user_jobs
  end
end
