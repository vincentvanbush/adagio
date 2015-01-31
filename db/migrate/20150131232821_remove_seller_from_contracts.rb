class RemoveSellerFromContracts < ActiveRecord::Migration
  def change
    change_table :contracts do |t|
      t.remove_references :seller
    end
  end
end
