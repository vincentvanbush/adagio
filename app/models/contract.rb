class Contract < ActiveRecord::Base
  belongs_to :auction

  belongs_to :buyer, class_name: "User"

  has_one :seller_comment, class_name: "Comment", foreign_key: :contract_id, dependent: :nullify
  has_one :buyer_comment, class_name: "Comment", foreign_key: :contract_id, dependent: :nullify

  validates :auction, presence: true
  validates :buyer, presence: true

  validate :buyer_not_same_as_auction_user

  def buyer_not_same_as_auction_user
    buyer != auction.user
  end

  # Default accessors seem not to work properly, both returning the same
  # comment, hence the overridden ones below. It's sort of a TODO.
  def buyer_comment
    Comment.find_by(id: self.buyer_comment_id)
  end

  def seller_comment
    Comment.find_by(id: self.seller_comment_id)
  end
end
