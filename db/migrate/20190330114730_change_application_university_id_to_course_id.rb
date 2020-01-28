class ChangeApplicationUniversityIdToCourseId < ActiveRecord::Migration[5.2]
  def change
    remove_column :applications, :university_id
    add_column :applications, :course_id, :integer
    add_column :applications, :status, :integer, default: 0
  end
end
