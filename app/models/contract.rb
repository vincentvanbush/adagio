class Contract < ActiveRecord::Base
  belongs_to :auction

  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"

  has_one :seller_comment, class_name: "Comment", dependent: :destroy
  has_one :buyer_comment, class_name: "Comment", dependent: :destroy

  validates :auction, presence: true
  validates :seller, presence: true
  validates :buyer, presence: true, inequality: { to: :seller }
end
