class Admin::DashboardController < Admin::BaseController
  def index
    @orders = Order.grouped_by_status
  end
end
