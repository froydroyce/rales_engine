class Api::V1::Invoices::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemsSerializer.new(Invoice.invoice_items(params[:id]))
  end
end
