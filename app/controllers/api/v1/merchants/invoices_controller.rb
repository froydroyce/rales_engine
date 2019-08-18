class Api::V1::Merchants::InvoicesController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Merchant.invoices(params[:id]))
  end
end
