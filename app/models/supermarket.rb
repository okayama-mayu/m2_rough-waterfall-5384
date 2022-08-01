class Supermarket < ApplicationRecord
  has_many :customers

  def unique_items
    customers.joins(:items).select('items.name as item_name, items.created_at as time').distinct.order(:time)
  end
end