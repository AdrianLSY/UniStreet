class AddRequirementsToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :credit_amount_req, :integer, default: 0
    add_column :courses, :english_grade_req, :integer, default: 0
    add_column :courses, :math_grade_req, :integer, default: 0
    add_column :courses, :science_amount_req, :integer, default: 0
  end
end
