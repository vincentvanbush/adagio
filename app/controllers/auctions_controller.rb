class AuctionsController < ApplicationController
  expose_decorated :auction
  expose_decorated(:auctions) { parent_object.auctions }
  expose :category
  expose :user
  expose(:parent) { parent_str }

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

  private

  def parent_object
    if params['user_id']
      User.find_by(id: params['user_id'])
    elsif params['category_id']
      Category.find_by(id: params['category_id'])
    end
  end

  def parent_str
    if parent_object.class == User
      parent_object.email
    elsif parent_object.class == Category
      parent_object.title
    end
  end
end
