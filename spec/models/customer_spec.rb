require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items }
    it { should have_many(:items).through(:customer_items) }
  end

  describe 'instance methods' do 
    describe '#total_price' do 
      it 'returns the total price of items associated with a customer' do 
        supermarket_1 = Supermarket.create!(name: Faker::Address.community, location: Faker::Address.city)
        customer_1 = supermarket_1.customers.create!(name: Faker::Name.name)

        item_1 = Item.create!(name: "milk", price: 7)
        item_2 = Item.create!(name: "cabbage", price: 5)
        item_3 = Item.create!(name: 'crackers', price: 2)

        CustomerItem.create!(customer_id: customer_1.id, item_id: item_1.id)
        CustomerItem.create!(customer_id: customer_1.id, item_id: item_2.id)
        CustomerItem.create!(customer_id: customer_1.id, item_id: item_3.id)

        expect(customer_1.total_price).to eq 14 
      end
    end
  end
end