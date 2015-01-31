class Auction < ActiveRecord::Base
  belongs_to :category
  has_one :contract
  belongs_to :user
  has_many :bids
end
