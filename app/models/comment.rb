class Comment < ActiveRecord::Base
  belongs_to :contract
  has_one :author
  belongs_to :user_for
end
