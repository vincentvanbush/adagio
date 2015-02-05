class Comment < ActiveRecord::Base
  belongs_to :auction

  belongs_to :author, class_name: "User", foreign_key: :author_id
  belongs_to :user_for, class_name: "User", foreign_key: :user_for_id

  validates :comment_type, presence: true, inclusion: {
    in: %w(positive negative neutral),
    message: 'its type has to be one of the following: positive negative neutral'
  }
  validates :content, presence: true
  validates :author, presence: true
  validates :user_for, presence: true
  validates :auction, presence: true

  validate :auction_finished, on: :create
  validate :proper_users, on: :create
  validate :auction_not_commented_yet, on: :create

  private

  def auction_finished
    errors.add(:auction, 'is not finished') unless auction.is_finished?
  end

  def proper_users
    combinations = [[auction.user, auction.winner], [auction.winner, auction.user]]
    errors.add(:author, 'does not match the other user') unless combinations.include? [author, user_for]
  end

  def auction_not_commented_yet
    if author == auction.user
      errors.add(:auction, 'already has a seller comment') if auction.seller_comment.present?
    elsif author == auction.winner
      errors.add(:auction, 'already has a buyer comment') if auction.buyer_comment.present?
    end
  end
end
