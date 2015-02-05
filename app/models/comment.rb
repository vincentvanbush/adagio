class Comment < ActiveRecord::Base
  belongs_to :auction

  belongs_to :author, class_name: "User", foreign_key: :author_id
  belongs_to :user_for, class_name: "User", foreign_key: :user_for_id

  validates :comment_type, presence: true, inclusion: {
    in: %w(positive negative neutral),
    message: 'its type has to be one of the following: positive negative neutral'
  }
  validates :author, presence: true
  validates :user_for, presence: true
  validates :auction, presence: true

  validate :auction_finished, on: :create
  validate :proper_users, on: :create

  def auction_finished
    auction.is_finished?
  end

  def proper_users
    [[auction.user, auction.winner], [auction.winner, auction.user]].include? [author, user_for]
  end
end
