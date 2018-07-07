class AddDelFlashToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :del_flash, :integer, default: 0
  end
end
