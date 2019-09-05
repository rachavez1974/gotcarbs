class ChangeBirthdayColumnToDateInUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :birthday, :date, using: 'birthday::date'
  end

  def down  
    change_column :users, :birthday, :string
  end
end
