class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :location
      t.string :difficulty
      t.datetime :date
    end
  end
end
