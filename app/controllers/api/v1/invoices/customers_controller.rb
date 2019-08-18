class Api::V1::Invoices::CustomersController < ApplicationController
  def show
    render json: CustomerSerializer.new(Invoice.customer(params[:id]))
  end
end
