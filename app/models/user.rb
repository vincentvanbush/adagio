class User < ActiveRecord::Base
  require 'iso/iban'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :auctions
  has_many :bids
  has_many :addresses
  has_many :issued_comments, class_name: 'Comment', foreign_key: :author_id
  has_many :received_comments, class_name: 'Comment', foreign_key: :user_for_id

  validate :iban_valid

  def won_auctions
    Auction.all.select { |a| a.winner = self }
  end

  private

  def iban_valid
    errors.add(:account_number, 'is not a valid IBAN') unless ISO::IBAN.new(account_number).valid?
  end
end
