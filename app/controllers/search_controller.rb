class SearchController < ApplicationController
  def search_params
    params.permit(:search, :title, :also_descriptions, :min_price, :max_price, :auction_type)
  end
end
