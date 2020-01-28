class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.string :intake
      t.integer :status, default: 0
      t.integer :university_id
      t.timestamps
    end
  end
end
