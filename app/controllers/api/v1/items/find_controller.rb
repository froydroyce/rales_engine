class Api::V1::Items::FindController < ApplicationController
  before_action :convert_price

  def show
    render json: ItemSerializer.new(Item.find_by(find_params))
  end

  def index
    render json: ItemSerializer.new(Item.where(find_params))
  end

  private

  def find_params
    params.permit(
      :id,
      :name,
      :description,
      :unit_price,
      :merchant_id,
      :created_at,
      :updated_at
    )
  end

  def convert_price
    if params[:unit_price]
      params[:unit_price] = (params[:unit_price].to_f * 100).round.to_i.to_s
    end
  end
end
