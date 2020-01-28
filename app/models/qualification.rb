class Qualification < ApplicationRecord
  belongs_to :user
  belongs_to :paper
  validates_presence_of :paper_id, :grade
  validates_uniqueness_of   :paper_id, scope: :user_id
  enum grade: %i[Ungraded A+ A A- B+ B C+ C D E F G]
end