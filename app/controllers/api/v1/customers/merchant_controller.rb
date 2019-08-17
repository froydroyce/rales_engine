class Api::V1::Customers::MerchantController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.favorite_merchant(params[:id]))
  end
end
