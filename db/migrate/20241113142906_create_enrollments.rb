class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.references :account, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.references :semester, null: false, foreign_key: true

      t.timestamps
    end
  end
end
