class ItemOrdersController < ApplicationController 
  def update
    item_order = ItemOrder.find(params[:id])
    item_order.update(fulfilled: true)
    item_order.item.update_attributes(:inventory => (item_order.item.inventory - item_order.quantity))
    flash[:notice] = "This item has been fulfilled - #{item_order.item.name}"
    redirect_to "/merchant/orders/#{item_order.order.id}"
  end
end