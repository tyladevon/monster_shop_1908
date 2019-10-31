class Admin::OrdersController < Admin::BaseController

  def update
    order = Order.find(params[:id])
    order.update(status: "Shipped")
    redirect_to '/admin'
  end
end
