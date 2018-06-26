class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price, precision: 8, scale: 2
      t.text :description
      t.integer :quantity
      t.integer :status
      t.string :image
      t.belongs_to :category, index: true

      t.timestamps
    end
  end
end
