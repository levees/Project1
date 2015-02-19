class AddUsercolumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username,     :string
    add_column :users, :first_name,   :string
    add_column :users, :last_name,    :string
    add_column :users, :zipcode,      :string
    add_column :users, :userlevel,    :integer,   :default => 1
  end
end
