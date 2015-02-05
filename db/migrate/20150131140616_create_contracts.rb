class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.references :auction, index: true
      t.references :seller, index: true
      t.references :buyer, index: true
    end
    add_foreign_key :contracts, :auctions
    add_foreign_key :contracts, :users, column: :seller_id
    add_foreign_key :contracts, :users, column: :buyer_id
  end
end
