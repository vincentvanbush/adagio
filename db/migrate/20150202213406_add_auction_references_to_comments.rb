class AddAuctionReferencesToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :auction, index: true
    add_foreign_key :comments, :auctions
  end
end
