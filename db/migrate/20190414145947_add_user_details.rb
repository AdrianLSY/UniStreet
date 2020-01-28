class AddUserDetails < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :gender
    remove_column :users, :birthdate
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :title, :integer, default: 0
    add_column :users, :gender, :integer, default: 0
    add_column :users, :birthdate, :datetime
    add_column :users, :address, :text
    add_column :users, :phone, :string
    add_column :users, :nric_passport, :string
    add_column :users, :nationality, :integer, default: 0
  end
end
