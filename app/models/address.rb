class Address < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :street, presence: true, allow_blank: false, length: { maximum: 100 }
  validates :city, presence: true, allow_blank: false, length: { maximum: 100 }
  validates :house_number, presence: true, allow_blank: false, length: { maximum: 10 }
  validates :postal_code, presence: true, format: { with: /[0-9]{2}\-[0-9]{3}/ }
end
