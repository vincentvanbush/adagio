class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :postal_code
      t.string :street
      t.string :house_number
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :addresses, :users
  end
end
