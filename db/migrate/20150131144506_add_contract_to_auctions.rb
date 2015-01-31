class AddContractToAuctions < ActiveRecord::Migration
  def change
    add_reference :auctions, :contract, index: true
    add_foreign_key :auctions, :contracts
  end
end
