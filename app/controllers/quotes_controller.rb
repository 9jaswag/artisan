class QuotesController < ApplicationController
  before_action :check_quote_type, only: [:new]

  def new
    @services = ['general-cleaning', 'window-cleaning'] if params[:type] == 'custom'
    @services = ['contract-service'] if params[:type] == 'contract'
  end

  def create
    #
  end

  private
    def check_quote_type
      redirect_to dashboard_path if params[:type] != 'custom' and params[:type] != 'contract'
    end
end
