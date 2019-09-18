class AddColumnToOrderedItems < ActiveRecord::Migration[5.2]
  def change
    add_column :ordered_items, :cart_id, :integer
  end
end
