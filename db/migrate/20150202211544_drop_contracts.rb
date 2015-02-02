class DropContracts < ActiveRecord::Migration
  def change
    remove_column :auctions, :contract_id
    remove_column :comments, :contract_id
    drop_table :contracts
  end
end
