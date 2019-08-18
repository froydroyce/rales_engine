class Api::V1::Customers::InvoicesController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Customer.invoices(params[:id]))
  end
end
