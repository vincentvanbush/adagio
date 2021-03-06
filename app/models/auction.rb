class Auction < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :bids, dependent: :destroy
  has_one :seller_comment, class_name: "Comment", foreign_key: :auction_id, dependent: :nullify
  has_one :buyer_comment, class_name: "Comment", foreign_key: :auction_id, dependent: :nullify

  validates :category, presence: true
  validates :user, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 100000000 }

  validates :auction_type, inclusion: {
    in: %w(instant classic),
    message: "its type has to be 'instant' or 'classic'"
  }

  validates :title, presence: true, allow_blank: false, length: {
    maximum: 40,
    too_long: "length has to be up to 40"
  }
  validates :description, presence: true, allow_blank: false, length: {
    maximum: 1000,
    too_long: "length has to be up to 1000"
  }

  validates_datetime :start_date, before: :end_date

  validate :up_to_one_bid, if: :instant_auction?

  # This is ugly as hell, but it's a part of our school assignment to do it
  # like this. Sorry.
  def end_prematurely
    connection = ActiveRecord::Base.connection.raw_connection
    connection.exec("select end_auction(#{id})")
  end

  def self.search_title(by, also_descriptions)
    search_condition = ("%" + by + "%").downcase
    if also_descriptions
      where(['lower(title) like ? or lower(description) like ?', search_condition, search_condition])
    else
      where(['lower(title) like ?', search_condition])
    end
  end

  def self.search_min_price(min)
    where(['price >= ?', min.to_f])
  end

  def self.search_max_price(max)
    where(['price <= ?', max.to_f])
  end

  def self.search_auction_type(auc_t)
    where(['auction_type = ?', auc_t])
  end

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

  def has_bids_by?(user)
    true unless bids.all.select { |b| b.user == user }.blank?
  end

  def is_finished?
    if auction_type == 'instant'
      return true if bids.present?
    elsif auction_type == 'classic'
      return true if DateTime.now > end_date
    end
  end

  def up_to_one_bid
    errors.add(:bids, "number should be limited to 1 for an instant") if bids.count > 1
  end

  def winner
    return bids.order('price desc').first.user if bids.present?
    return nil
  end
end
