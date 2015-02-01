class Comment < ActiveRecord::Base
  belongs_to :contract

  belongs_to :author, class_name: "User", foreign_key: :author_id
  belongs_to :user_for, class_name: "User", foreign_key: :user_for_id

  validates :comment_type, presence: true, inclusion: {
    in: %w(positive negative neutral),
    message: 'its type has to be one of the following: positive negative neutral'
  }
  validates :author, presence: true
  validates :user_for, presence: true
  validates :contract, presence: true
end
