class CategoryDecorator < Draper::Decorator
  delegate_all

  def latest_five_auctions
    category.auctions.order("created_at").first(5)
  end
end
