class Admin::OrdersController < Admin::BaseController

  def update
    order = Order.find(params[:id])
    order.update(status: "Shipped")
  end
end
