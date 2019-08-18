class Api::V1::Invoices::MerchantsController < ApplicationController
  def show
    render json: MerchantSerializer.new(Invoice.merchant(params[:id]))
  end
end
