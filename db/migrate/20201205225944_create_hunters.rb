class CreateHunters < ActiveRecord::Migration
  def change
    create_table :hunters do |t|
      t.string :name
      t.integer :age
      t.integer :years_experience
    end
  end
end
