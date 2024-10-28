class AddPhoneNumberToLecturers < ActiveRecord::Migration[7.0]
  def change
    add_column :lecturers, :phone_number, :string
    add_column :lecturers, :gender, :string
  end
end
