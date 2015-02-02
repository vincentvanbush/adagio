class AuctionsController < ApplicationController
  expose_decorated :auction
  expose_decorated :auctions do
    if params['user_id']
      obj = User.find_by(id: params['user_id']).auctions
    elsif params['category_id']
      Category.find_by(id: params['category_id']).auctions
    end
  end
  expose :category
  expose :user

  def new
  end

  def create
  end

  def show
  end

  def index
  end

  def destroy
    auction.destroy
    redirect_to category_auctions_url(auction.category), notice: 'Auction deleted successfully'
  end

  def edit
  end

  def update
  end
end
