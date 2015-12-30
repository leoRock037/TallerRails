class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.references :user, index: true, foreign_key: true
      t.string :status

      t.timestamps null: false
    end
  end
end
