class Api::V1::Items::MerchantsController < ApplicationController
  def show
    render json: MerchantSerializer.new(Item.merchant(params[:id]))
  end
end
