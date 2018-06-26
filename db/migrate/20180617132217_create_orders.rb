class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :note
      t.integer :total, default: 0
      t.integer :status, null: false, default: 0
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
