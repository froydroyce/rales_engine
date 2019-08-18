class Api::V1::Items::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemsSerializer.new(Item.invoice_items(params[:id]))
  end
end
