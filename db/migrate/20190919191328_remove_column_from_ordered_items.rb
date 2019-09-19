class RemoveColumnFromOrderedItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :ordered_items, :order_id
  end
end
