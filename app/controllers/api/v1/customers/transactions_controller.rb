class Api::V1::Customers::TransactionsController < ApplicationController
  def index
    render json: TransactionSerializer.new(Customer.transactions(params[:id]))
  end
end
