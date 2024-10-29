class Exam < ApplicationRecord
  belongs_to :semester
  has_many :exam_courses
  has_many :courses, through: :exam_courses
  has_many :exam_registrations
  has_many :accounts, through: :exam_registrations
end