class CreateExams < ActiveRecord::Migration[7.0]
  def change
    create_table :exams do |t|
      t.date :date
      t.time :start_time
      t.time :end_time
      t.references :course, null: false, foreign_key: true
      t.references :semester, null: false, foreign_key: true

      t.timestamps
    end
  end
end
