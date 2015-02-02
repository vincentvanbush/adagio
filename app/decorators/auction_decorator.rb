class AuctionDecorator < Draper::Decorator
  delegate_all

  def current_price
    bids.maximum('price') or price
  end
end
