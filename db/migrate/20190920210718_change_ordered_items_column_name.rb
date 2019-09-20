class ChangeOrderedItemsColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :ordered_items, :cart_id, :order_id
  end
end
