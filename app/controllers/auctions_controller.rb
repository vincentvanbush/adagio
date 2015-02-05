class AuctionsController < ApplicationController
  expose_decorated :auction
  expose_decorated(:auctions) { filtered_auctions }
  expose :category
  expose :user
  expose(:bids) { auction.bids }
  expose :contract
  expose(:parent) { parent_str }

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def create
    self.auction = Auction.new(auction_params)
    auction.user = current_user
    auction.start_date = DateTime.now

    if auction.save
      auctions << auction
      redirect_to category_auction_url(auction.category, auction), notice: 'Auction successfully created'
    else
      render 'auctions/new'
    end
  end

  def destroy
    auction.destroy
    redirect_to category_auctions_url(auction.category), notice: 'Auction deleted successfully'
  end

  private

  def filtered_auctions
    if parent_object.nil?
      filtered = Auction.all
    else
      filtered = parent_object.auctions.paginate(page: params['page'], per_page: 30)
    end
  end

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

  def auction_params
    params.require(:auction).permit(:price, :title, :description, :auction_type, :start_date, :end_date, :category_id, :user_id)
  end
end
