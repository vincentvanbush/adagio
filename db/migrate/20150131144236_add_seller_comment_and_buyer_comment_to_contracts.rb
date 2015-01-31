class AddSellerCommentAndBuyerCommentToContracts < ActiveRecord::Migration
  def change
    add_reference :contracts, :seller_comment, index: true
    add_foreign_key :contracts, :comments, column: :seller_comment_id

    add_reference :contracts, :buyer_comment, index: true
    add_foreign_key :contracts, :comments, column: :buyer_comment_id
  end
end
