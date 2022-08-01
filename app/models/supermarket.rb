class Supermarket < ApplicationRecord
  has_many :customers

  def unique_items
    binding.pry 
  end
end