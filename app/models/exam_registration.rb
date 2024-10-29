class ExamRegistration < ApplicationRecord
  belongs_to :account
  belongs_to :exam
end
