class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to :user

  validates :price, presence: true, numericality: { greater_than: 0, less_than: 100000000 }
  validates :user, presence: true
  validates :auction, presence: true

  validate :not_finished, on: :create
  validate :no_bid_yet, if: :instant_auction?, on: :create
  validate :is_best_bid, on: :create
  validate :cannot_bid_own_auction, on: :create
  validate :cannot_outbid_own_bid, on: :create
  validate :instant_should_equal_price, on: :create

  private

  def instant_auction?
    auction.auction_type == 'instant'
  end

  def not_finished
    errors.add(:auction, 'has already been finished') if auction.is_finished?
  end

  def no_bid_yet
    errors.add(:auction, 'should have up to one bid') if auction.bids.count > 0
  end

  def is_best_bid
    if price.present? && auction.price > price
      errors.add(:price, 'should beat auction\'s initial price')
    end
    if auction.bids.present?
      errors.add(:price, 'should beat the best bid') if price <= auction.bids.maximum('price')
    end
  end

  def cannot_outbid_own_bid
    best_bid = auction.bids.order('price desc').first
    if best_bid != nil && user == best_bid.user
      errors.add(:auction, 'cannot be outbid by best bid\'s owner')
    end
  end

  def cannot_bid_own_auction
    errors.add(:auction, 'cannot be outbid by its owner') if user == auction.user
  end

  def instant_should_equal_price
    if auction.auction_type == 'instant' && price != auction.price
      errors.add(:price, 'should be equal to initial price for an instant auction')
    end
  end
end
