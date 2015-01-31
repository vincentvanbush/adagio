class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.decimal :price, precision: 10, scale: 2
      t.references :user, index: true
      t.references :auction, index: true
    end
    add_foreign_key :bids, :users
    add_foreign_key :bids, :auctions
  end
end
