class Api::V1::Items::DateController < ApplicationController
  def show
    render json: BestDaySerializer.new(Invoice.best_day(params[:id]))
  end
end
