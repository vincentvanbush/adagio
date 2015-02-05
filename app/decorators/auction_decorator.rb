class AuctionDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers
  delegate_all

  def current_price
    bids.maximum('price') or price
  end

  def bid_link
    if auction_type == 'instant'
      str = '(buy now)'
    else
      str = '(make a bid)'
    end
    h.link_to str, new_category_auction_bid_url(category, self)
  end

  def bids_count_by(user)
    bids.all.select { |b| b.user == user }.count
  end
end
