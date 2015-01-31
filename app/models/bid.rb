class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to :user

  validates :price, presence: true, numericality: true
  validates :user, presence: true
  validates :auction, presence: true

  validate :no_bid_yet, if: :instant_auction?

  def instant_auction?
    auction.auction_type == 'instant'
  end

  def no_bid_yet
    errors.add(:auction, "Auction bids should be limited to 1 for an instant") if auction.bids.count > 0
  end
end
