class RemoveFinishedAtFromAuctions < ActiveRecord::Migration
  def change
    remove_column :auctions, :finished_at
  end
end
