class CreateQualifications < ActiveRecord::Migration[5.2]
  def change
    create_table :qualifications do |t|
      t.integer :user_id
      t.integer :course_id
      t.integer :paper_id
      t.integer :grade, default: 0
      t.timestamps
    end
  end
end
