class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to :user

  validates :price, presence: true, numericality: true
  validates :user, presence: true
  validates :auction, presence: true
end
