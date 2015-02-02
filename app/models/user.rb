class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :auctions
  has_many :bids
  has_many :addresses
  has_many :issued_comments, class_name: 'Comment', foreign_key: :author_id
  has_many :received_comments, class_name: 'Comment', foreign_key: :user_for_id
end
