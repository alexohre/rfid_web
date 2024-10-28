class CreateLecturerCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :lecturer_courses do |t|
      t.references :lecturer, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
