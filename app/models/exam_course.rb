class ExamCourse < ApplicationRecord
  belongs_to :exam
  belongs_to :course
end
