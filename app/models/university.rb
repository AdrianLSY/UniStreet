class University < ApplicationRecord
  has_many :courses
  has_many :users
  has_many :applications, :through => :courses
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_presence_of(:description, :phone, :address)
end
