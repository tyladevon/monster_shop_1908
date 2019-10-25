class OrdersController <ApplicationController

  def new

  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    order = Order.create((order_params).merge(user_id: current_user.id))
    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      session.delete(:cart)
      redirect_to "/orders/#{order.id}"
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end

  def index
    @user = current_user
  end


  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
