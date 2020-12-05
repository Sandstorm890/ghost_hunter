class CreateUsersJobs < ActiveRecord::Migration
  def change
    create_table :users_jobs do |t|
      t.integer :user_id
      t.integer :job_id
    end
  end
end
