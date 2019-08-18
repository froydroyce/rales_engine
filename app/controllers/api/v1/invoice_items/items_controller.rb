class Api::V1::InvoiceItems::ItemsController < ApplicationController
  def show
    render json: ItemSerializer.new(InvoiceItem.item(params[:id]))
  end
end
