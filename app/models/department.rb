class Department < ApplicationRecord
  belongs_to :faculty  # Department belongs to Faculty
  has_many :courses, dependent: :destroy  # Department has many Courses
end
