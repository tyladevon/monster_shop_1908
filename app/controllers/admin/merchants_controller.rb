class Admin::MerchantsController < Admin::BaseController

  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:type] == "enable"
      merchant.update(enabled?: true)
      flash[:notice] = "#{merchant.name} account is enabled."
    elsif params[:type] == "disable"
      merchant.update(enabled?: false)
      flash[:notice] = "#{merchant.name} account is disabled."
    end
    redirect_to '/admin/merchants'
  end

 
  def show
    @merchant = Merchant.find(params[:id])
  end
end

