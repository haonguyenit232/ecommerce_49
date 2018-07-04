class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.integer :role, null: false, default: 0
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
