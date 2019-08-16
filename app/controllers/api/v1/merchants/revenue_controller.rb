class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.by_total_revenue(params[:quantity]))
  end

  def show
    if params[:date]
      date = params[:date]
      id = params[:id]
      render json: RevenueSerializer.new(Merchant.revenue_for_date(date, id))
    else
      render json: RevenueSerializer.new(Merchant.total_revenue(params[:id]))
    end
  end
end
