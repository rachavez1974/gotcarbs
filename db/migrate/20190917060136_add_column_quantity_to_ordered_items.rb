class AddColumnQuantityToOrderedItems < ActiveRecord::Migration[5.2]
  def change
    add_column :ordered_items, :quanity, :integer
  end
end
