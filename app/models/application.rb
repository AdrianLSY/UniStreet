class Application < ApplicationRecord
  belongs_to :user
  belongs_to :course
  enum status: %i[pending approved denied]
end
