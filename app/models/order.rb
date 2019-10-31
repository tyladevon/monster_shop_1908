class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :status

  has_many :item_orders
  has_many :items, through: :item_orders
  has_many :merchants, through: :item_orders
  belongs_to :user

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def total_items
    item_orders.sum(:quantity)
  end

  def self.grouped_by_status
    order("
      CASE
        WHEN status = 'Packaged' THEN '0'
        WHEN status = 'Pending' THEN '1'
        WHEN status = 'Shipped' THEN '2'
        WHEN status = 'Cancelled' THEN '3'
      END
      ")
  end
end
