class SetDefaultValuesToTermsAndEmaiListInUser < ActiveRecord::Migration[5.2]
  def change
     change_column :users, :terms, :boolean, default: false
     change_column :users, :email_list, :boolean, default: false
  end
end
