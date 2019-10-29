class Merchant::ItemsController < Merchant::BaseController

  def index
    @items = Item.where(merchant_id: current_user.merchant_id)
  end

  def update 
    item = Item.find(params[:id])
    if params["type"] == "deactivate"
      item.update(active?: false)
      flash[:notice] = "#{item.name} is no longer for sale"
    elsif params["type"] == "activate"
      item.update(active?: true)
      flash[:notice] = "#{item.name} is available for sale"
    end
    redirect_to '/merchant/items'
  end

  def destroy
    item = Item.find(params[:id])
    if item.no_orders?
      item.destroy
      flash[:notice] = "Your #{item.name} has been deleted"
      redirect_to "/merchant/items"
    end
  end
end
