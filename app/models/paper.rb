class Paper < ApplicationRecord
  has_many :qualifications
  enum exam: %i[Unspecified SPM IGCSE]

  def exam_with_name
    "#{self.exam}: #{self.name}"
  end
end
