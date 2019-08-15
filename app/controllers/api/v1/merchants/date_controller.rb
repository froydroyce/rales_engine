class Api::V1::Merchants::DateController < ApplicationController
  def index
    render json: DateSerializer.new(Merchant.revenue_for_date(params[:date]))
  end
end
