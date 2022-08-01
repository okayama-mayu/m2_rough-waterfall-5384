class Supermarket < ApplicationRecord
  has_many :customers

  def unique_items
    customers.joins(:items).select('items.name as item_name, items.created_at as time').distinct.order(:time)
  end

  def top_3_items
    customers.joins(:items).select('items.id as item_id, items.name as item_name, count(*) as item_count').group('items.id').order(item_count: :desc).limit(3)
  end
end