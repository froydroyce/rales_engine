class Api::V1::Transactions::InvoicesController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Transaction.invoice(params[:id]))
  end
end
