class AddDetailsToUniversity < ActiveRecord::Migration[5.2]
  def change
    add_column :universities, :address, :string
    add_column :universities, :phone, :string
  end
end
