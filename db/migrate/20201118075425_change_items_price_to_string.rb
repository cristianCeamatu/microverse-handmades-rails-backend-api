class ChangeItemsPriceToString < ActiveRecord::Migration[6.0]
  def change
    change_column :items, :price, :string
  end
end
