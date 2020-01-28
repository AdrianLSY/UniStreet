class Course < ApplicationRecord
  belongs_to :university
  has_many :qualifications
  has_many :applications
  validates_presence_of(:name, :description, :intake, :university_id, :credit_amount_req, :english_grade_req, :math_grade_req, :science_amount_req)
  enum status: %i[ongoing completed]
  enum english_grade_req: %i[none pass credit], _prefix: :english
  enum math_grade_req: %i[none pass credit], _prefix: :maths
end

