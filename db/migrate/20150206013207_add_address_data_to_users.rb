class AddAddressDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :postal_code, :string
    add_column :users, :street, :string
    add_column :users, :house_number, :string
  end
end
