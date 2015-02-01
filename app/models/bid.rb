class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to :user

  validates :price, presence: true, numericality: true
  validates :user, presence: true
  validates :auction, presence: true

  validate :no_bid_yet, if: :instant_auction?
  validate :is_best_bid, on: :create
  validate :cannot_outbid_own_bid, on: :create

  private

  def instant_auction?
    auction.auction_type == 'instant'
  end

  def no_bid_yet
    errors.add(:auction, 'should have up to one bid') if auction.bids.count > 0
  end

  def is_best_bid
    if price <= (auction.bids.maximum('price') || auction.price)
      errors.add(:auction, 'bid should beat the initial price and the best bid')
    end
  end

  def cannot_outbid_own_bid
    best_bid = auction.bids.order('price desc').first
    if best_bid != nil && user == best_bid.user
      errors.add(:auction, 'cannot outbid your own bid')
    end
  end
end
