class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.decimal :reward
      t.boolean :urgent
      t.integer :user_id

      t.timestamps
    end
  end
end
