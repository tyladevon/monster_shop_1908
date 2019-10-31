class Merchant::ItemsController < Merchant::BaseController

  def index
    @items = Item.where(merchant_id: current_user.merchant_id)
  end

  def edit
    @merchant = current_user.merchant
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if params["type"] == "deactivate"
      item.update(active?: false)
      flash[:notice] = "#{item.name} is no longer for sale"
      redirect_to '/merchant/items'
    elsif params["type"] == "activate"
      item.update(active?: true)
      flash[:notice] = "#{item.name} is available for sale"
      redirect_to '/merchant/items'
    elsif params["type"] == "edit"
      item.update(item_params)
      item.image = 'https://via.placeholder.com/36' if item.image.blank?
      if item.save 
        flash[:success] = "#{item.name} has been updated!"
        redirect_to '/merchant/items'
      else 
        flash[:error] = item.errors.full_messages.to_sentence
        redirect_to "/merchant/items/#{item.id}"
      end
    end
  end

  def new
    @merchant = current_user.merchant
    @item = @merchant.items.new
  end

  def create
    merchant = current_user.merchant
    item = merchant.items.new(item_params)
    item.image = 'https://via.placeholder.com/36' if item.image.blank?
    if item.save
      flash[:success] = "#{item.name} has been created!"
      redirect_to '/merchant/items'
    else
      flash[:error] = item.errors.full_messages.to_sentence
      redirect_to '/merchant/items/new'
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    flash[:notice] = "Your #{item.name} has been deleted"
    redirect_to "/merchant/items"
  end
  
  private
    def item_params
      params.require(:item).permit(:name, :description, :price, :image, :inventory)
    end
end
