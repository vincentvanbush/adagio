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
    Auction.all.select { |a| a.winner == self }
  end

  # This is ugly as hell, but as a part of my school assignment I had to
  # implement some functionality like this.
  def positive_comment_rate
    connection = ActiveRecord::Base.connection.raw_connection
    connection.exec("select positive_percentage(#{id})").getvalue(0, 0).to_f
  end

  private

  def iban_valid
    if account_number.present?
      errors.add(:account_number, 'is not a valid IBAN') unless ISO::IBAN.new(account_number).valid?
    else
      errors.add(:account_number, 'cant be blank')
    end
  end
end
