require 'rails_helper'

RSpec.describe Supermarket, type: :model do
  describe 'relationships' do
    it { should have_many :customers }
  end

  describe 'instance methods' do 
    describe '#unique_items' do 
      supermarket_1 = Supermarket.create!(name: Faker::Address.community, location: Faker::Address.city)
      supermarket_2 = Supermarket.create!(name: Faker::Address.community, location: Faker::Address.city)

      customer_1 = supermarket_1.customers.create!(name: Faker::Name.name)
      customer_2 = supermarket_1.customers.create!(name: Faker::Name.name)

      item_1 = Item.create!(name: "milk", price: 7)
      item_2 = Item.create!(name: "cabbage", price: 5)
      item_3 = Item.create!(name: 'crackers', price: 2)
      item_4 = Item.create!(name: 'chips', price: 4)
      item_5 = Item.create!(name: 'lotion', price: 9)

      CustomerItem.create!(customer_id: customer_1.id, item_id: item_1.id)
      CustomerItem.create!(customer_id: customer_1.id, item_id: item_2.id)

      CustomerItem.create!(customer_id: customer_2.id, item_id: item_1.id)
      CustomerItem.create!(customer_id: customer_2.id, item_id: item_3.id)
      CustomerItem.create!(customer_id: customer_2.id, item_id: item_4.id)

      actual = supermarket_1.unique_items.map do |item| 
        item.name 
      end

      expected = [item_1, item_2, item_3, item_4].map do |item|
        item.name 
      end

      expect(actual).to eq(expected)
    end
  end
end