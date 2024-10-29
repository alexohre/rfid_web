class CreateExamRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :exam_registrations do |t|
      t.references :account, null: false, foreign_key: true
      t.references :exam, null: false, foreign_key: true

      t.timestamps
    end
  end
end
