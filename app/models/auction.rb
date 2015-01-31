class Auction < ActiveRecord::Base
  belongs_to :category
  has_one :contract, dependent: :destroy
  belongs_to :user
  has_many :bids, dependent: :destroy

  validates :category, presence: true
  validates :user, presence: true
  validates :price, presence: true, numericality: true

  validates :auction_type, inclusion: {
    in: %w(instant classic),
    message: "its type has to be 'instant' or 'classic'"
  }

  validates :title, presence: true, allow_blank: false, length: {
    maximum: 40,
    too_long: "its length has to be up to #{count}"
  }
  validates :description, presence: true, allow_blank: false, length: {
    maximum: 1000,
    too_long: "its length has to be up to #{count}"
  }

  validates_datetime :start_date, before: :end_date
  validates_datetime :finished_at, on_or_before: :end_date, if: :is_finished?

  validate :up_to_one_bid, if: :instant_auction?

  def instant_auction?
    auction_type == 'instant'
  end

  def is_finished?
    finished_at != nil
  end

  def up_to_one_bid
    errors.add(:bids, "should be limited to 1 for an instant") if bids.count > 1
  end
end
