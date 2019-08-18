class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Merchant.items(params[:id]))
  end
end
