class Auction < ActiveRecord::Base
  belongs_to :category
  has_one :transaction
  belongs_to :user
  has_many :bids
end
