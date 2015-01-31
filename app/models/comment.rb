class Comment < ActiveRecord::Base
  belongs_to :contract
  belongs_to :user
end
