class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :inventory, greater_than_or_equal_to: 0

  def average_review
    reviews.average(:rating)
  end

  def sorted_reviews(limit, order)
    reviews.order(rating: order).limit(limit)
  end

  def no_orders?
    item_orders.empty?
  end

  def self.top_five_most_popular
    Item.joins(:item_orders).select("items.name, sum(quantity) as sumq").group(:name).order('sumq DESC').limit(5)
  end

  def self.least_popular
    Item.joins(:item_orders).select("items.name, sum(quantity) as sumq").group(:name).order('sumq ASC').limit(5)
  end
end
