class AddCommentsReferencesToAuctions < ActiveRecord::Migration
  def change
    add_reference :auctions, :seller_comment, index: true
    add_foreign_key :auctions, :comments, column: :seller_comment_id
    add_reference :auctions, :buyer_comment, index: true
    add_foreign_key :auctions, :comments, column: :buyer_comment_id
  end
end
