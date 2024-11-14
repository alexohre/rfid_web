class Enrollment < ApplicationRecord
  belongs_to :account
  belongs_to :course
  belongs_to :semester
end
