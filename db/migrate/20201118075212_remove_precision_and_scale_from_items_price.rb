class RemovePrecisionAndScaleFromItemsPrice < ActiveRecord::Migration[6.0]
  def change
    change_column :items, :price, :decimal
  end
end
