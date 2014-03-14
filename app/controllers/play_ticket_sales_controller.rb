class PlayTicketSalesController < ActionController::Base
  def index
    render json: PlayTicketSale.limit(10)
  end
end
