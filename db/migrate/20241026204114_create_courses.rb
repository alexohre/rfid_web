class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :course_title
      t.string :course_code
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
    add_index :courses, :course_code, unique: true
  end
end
