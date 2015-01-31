class Comment < ActiveRecord::Base
  belongs_to :contract
  has_one :author
  belongs_to :user_for

  validates :comment_type, presence: true, inclusion: {
    in: %w(positive negative neutral),
    message: 'its type has to be one of the following: positive negative neutral'
  }
  validates :author, presence: true
  validates :user_for, presence: true
  validates :contract, presence: true
end
