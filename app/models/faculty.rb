class Faculty < ApplicationRecord
  has_many :departments, dependent: :destroy  # Faculty has many Departments
end
