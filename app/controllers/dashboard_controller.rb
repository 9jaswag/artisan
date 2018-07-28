class DashboardController < ApplicationController
  def index
    @quotes = Quote.all.order(created_at: :desc).paginate(page: params[:page], per_page: 8)
  end
end
