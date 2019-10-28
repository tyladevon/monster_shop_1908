class Merchant <ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :item_orders, through: :items
  has_many :orders, through: :item_orders
  has_many :users

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip


  def no_orders?
    item_orders.empty?
  end

  def item_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def distinct_cities
    item_orders.distinct.joins(:order).pluck(:city).sort
  end

  def merch_item_count(order)
    item_orders.where(order_id: order.id).sum(:quantity)
  end

  def pending_orders
    orders.where(status: "Pending").distinct
  end

  def merch_total_value(order)
    item_orders.where(order_id: order.id).sum('item_orders.quantity * item_orders.price')
  end

end
