class CreateExamCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :exam_courses do |t|
      t.references :exam, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
