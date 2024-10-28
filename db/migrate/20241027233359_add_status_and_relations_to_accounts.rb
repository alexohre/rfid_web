class AddStatusAndRelationsToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :status, :integer, default: 0
    add_column :accounts, :tag_id, :string
    add_column :accounts, :mat_no, :string
    add_column :accounts, :lga, :string
    add_column :accounts, :other_name, :string
    add_reference :accounts, :faculty, null: true, foreign_key: true
    add_reference :accounts, :department, null: true, foreign_key: true
  end
end
