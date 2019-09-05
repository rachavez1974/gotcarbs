class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :email_list
      t.boolean :terms
      t.string :birthday

      t.timestamps
    end
  end
end
