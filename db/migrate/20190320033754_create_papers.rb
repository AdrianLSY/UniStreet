class CreatePapers < ActiveRecord::Migration[5.2]
  def change
    create_table :papers do |t|
      t.string :name
      t.integer :exam, default: 0
      t.timestamps
    end
  end
end
