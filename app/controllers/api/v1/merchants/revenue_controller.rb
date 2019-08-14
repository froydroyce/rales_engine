class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.by_total_revenue(params[:quantity]))
  end
end
