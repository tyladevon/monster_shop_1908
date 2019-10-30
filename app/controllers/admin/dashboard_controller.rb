class Admin::DashboardController < Admin::BaseController
  def index
    @orders = Order.where(status: "Packaged")
  end
end
