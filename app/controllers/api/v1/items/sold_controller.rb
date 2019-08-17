class Api::V1::Items::SoldController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.by_total_sold(params[:quantity]))
  end
end
