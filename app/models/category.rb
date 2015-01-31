class Category < ActiveRecord::Base
  has_many :auctions, dependent: :destroy

  validates :title, presence: true, allow_blank: false, length: {
    maximum: 30,
    too_long: "its length has to be up to #{count}"
  }
end
