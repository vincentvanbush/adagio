class AuctionDecorator < Draper::Decorator
  delegate_all

  def current_price
    bids.maximum('price') or price
  end

  def winner
    auction.bids.order('price desc').first.user
  end
end
