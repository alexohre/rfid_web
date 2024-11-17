class Exam < ApplicationRecord
  belongs_to :course

  scope :upcoming, -> { where('date >= ?', Date.today).order(:date, :start_time)}
  # Ex:- scope :active, -> {where(:active => true)}
end
