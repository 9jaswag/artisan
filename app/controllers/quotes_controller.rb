class QuotesController < ApplicationController
  before_action :check_quote_type, only: [:new]

  def new
    @services = ['general_cleaning', 'window_cleaning'] if params[:type] == 'custom'
    @services = ['contract_service'] if params[:type] == 'contract'
  end

  def create
    quote = Quote.create(data: quote_params)

    flash[:notice] = "Quote saved" if quote
    redirect_to dashboard_path
  end

  private
    def check_quote_type
      redirect_to dashboard_path if params[:type] != 'custom' and params[:type] != 'contract'
    end

    def quote_params
      params.require(:data).permit(:client_name, :total,
      { general_cleaning: [:people_per_job, :hours_for_job, :price_per_hour] },
      { window_cleaning: [:mensuration, :cost_per_measurement, :discount, :first_time_charge, :extra_clean_charge, :refrigerator_charge, :cabinets_charge, :oven_clean_charge] },
      { contract_service: [:monthly_visit, :price_per_visit, :cost_per_month, :contract_months] })
    end
end
