class BidsController < ApplicationController
  before_action :authenticate_user!

  expose(:auction)
  expose(:category) { auction.category }
  expose :bid
  expose(:bids) { auction.bids }

  def new
  end

  def create
    self.bid = Bid.new(bid_params)
    bid.user = current_user
    bid.auction = auction

    if bid.save
      auction.bids << bid
      redirect_to category_auction_url(category, auction), notice: 'Bid successfully created'
    else
      render 'bids/new'
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:price, :auction)
  end
end
