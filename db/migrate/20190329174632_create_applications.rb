class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.integer :user_id
      t.integer :university_id
      t.integer :status

      t.timestamps
    end
  end
end
