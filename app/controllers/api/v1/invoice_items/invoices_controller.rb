class Api::V1::InvoiceItems::InvoicesController < ApplicationController
  def show
    render json: InvoiceSerializer.new(InvoiceItem.invoice(params[:id]))
  end
end
