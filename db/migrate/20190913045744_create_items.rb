class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :menu_type
      t.integer :section
      t.decimal :price
      t.boolean :availability
      
      t.timestamps
    end
  end
end
