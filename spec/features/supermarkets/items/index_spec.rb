require 'rails_helper' 

RSpec.describe 'Supermarket Items Index Page', type: :feature do 
    # I am taken to the supermarkets item index page,
    # And I can see a UNIQUE list of all the items that the supermarket has
    it 'has a unique list of all items that the supermarket has' do 
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
        visit supermarket_items(supermarket_1)

        within('#item-0') do 
            expect(page).to have_content(item_1.name)
        end

        within('#item-1') do 
            expect(page).to have_content(item_2.name)
        end

        within('#item-2') do 
            expect(page).to have_content(item_3.name)
        end

        within('#item-3') do 
            expect(page).to have_content(item_4.name)
        end

        expect(page).to_not have_content(item_5.name)
    end
end