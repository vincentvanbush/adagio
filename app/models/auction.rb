class Auction < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :bids, dependent: :destroy
  has_one :seller_comment, class_name: "Comment", foreign_key: :auction_id, dependent: :nullify
  has_one :buyer_comment, class_name: "Comment", foreign_key: :auction_id, dependent: :nullify

  validates :category, presence: true
  validates :user, presence: true
  validates :price, presence: true, numericality: true

  validates :auction_type, inclusion: {
    in: %w(instant classic),
    message: "its type has to be 'instant' or 'classic'"
  }

  validates :title, presence: true, allow_blank: false, length: {
    maximum: 40,
    too_long: "its length has to be up to 40"
  }
  validates :description, presence: true, allow_blank: false, length: {
    maximum: 1000,
    too_long: "its length has to be up to 1000"
  }

  validates_datetime :start_date, before: :end_date

  validate :up_to_one_bid, if: :instant_auction?

  # Default accessors seem not to work properly, both returning the same
  # comment, hence the overridden ones below. It's sort of a TODO.
  def buyer_comment
    Comment.find_by(id: self.buyer_comment_id)
  end

  def seller_comment
    Comment.find_by(id: self.seller_comment_id)
  end

  def instant_auction?
    auction_type == 'instant'
  end

  def is_finished?
    if auction_type == 'instant'
      return true if bids.present?
    elsif auction_type == 'classic'
      return true if DateTime.now > end_date
    end
  end

  def up_to_one_bid
    errors.add(:bids, "should be limited to 1 for an instant") if bids.count > 1
  end
end
