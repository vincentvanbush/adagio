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

  def update
    self.auction = Auction.find(params['id'])
    if auction.update(update_params)
      redirect_to category_auction_url(auction.category, auction), notice: 'Auction successfully updated'
    else
      render 'auctions/edit'
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
      filtered = parent_object.auctions
    end
    filtered = filtered.search_title(params['title'], params['also_descriptions'].present?) if params['title'].present?
    filtered = filtered.search_min_price(BigDecimal.new(params['min_price'])) if params['min_price'].present?
    filtered = filtered.search_max_price(BigDecimal.new(params['max_price'])) if params['max_price'].present?
    filtered = filtered.search_auction_type(params['auction_type']) if params['auction_type'].present?
    filtered = filtered.paginate(page: params['page'], per_page: 30)
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
    params.require(:auction).permit(:id, :price, :title, :description, :auction_type, :start_date, :end_date, :category_id, :user_id)
  end

  def update_params
    params['auction'].permit(:description, :category_id)
  end
end
