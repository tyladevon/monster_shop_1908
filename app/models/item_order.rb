class ItemOrder <ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity

  belongs_to :item
  belongs_to :order

  def subtotal
    price * quantity
  end

  def filter_item_order(id)
    item.merchant_id == id
  end

  def can_be_fulfilled?
    item.inventory >= quantity && !fulfilled
  end
end