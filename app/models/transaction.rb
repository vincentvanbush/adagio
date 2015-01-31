class Transaction < ActiveRecord::Base
  belongs_to :auction

  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"

  has_one :seller_comment, class_name: "Comment"
  has_one :buyer_comment, class_name: "Comment"
end
