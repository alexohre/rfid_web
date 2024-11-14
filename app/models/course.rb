class Course < ApplicationRecord
  belongs_to :department  # Course belongs to Department
  # belongs_to :semester
  belongs_to :semester

  has_many :lecturer_courses, dependent: :destroy
  has_many :lecturers, through: :lecturer_courses

  has_many :enrollments
  has_many :accounts, through: :enrollments
  # has_many :semesters, through: :exams
end
