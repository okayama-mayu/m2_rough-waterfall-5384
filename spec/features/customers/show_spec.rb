require 'rails_helper' 
require 'faker'

RSpec.describe 'Customer Show Page', type: :feature do 
    # Story 1 of 3
    # As a visitor, 
    # When I visit a customer show page,
    # I see its a list of its items
    it 'shows the list of items they bought' do 
        supermarket_1 = Supermarket.create!(name: Faker::Address.community, location: Faker::Address.city)
        customer_1 = supermarket_1.customers.create!(name: Faker::Name.name)
        customer_2 = supermarket_1.customers.create!(name: Faker::Name.name)

        item_1 = Item.create!(name: "milk", price: 7)
        item_2 = Item.create!(name: "cabbage", price: 5)
        item_3 = Item.create!(name: 'crackers', price: 2)

        CustomerItem.create!(customer_id: customer_1.id, item_id: item_1.id)
        CustomerItem.create!(customer_id: customer_1.id, item_id: item_2.id)
        CustomerItem.create!(customer_id: customer_2.id, item_id: item_3.id)

        visit customer_path(customer_1) 

        expect(page).to have_content(customer_1.name)
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_2.name)

        expect(page).to_not have_content(customer_2.name)
        expect(page).to_not have_content(item_3.name)
    end

    # And the name of the supermarket that it belongs to
    it 'shows the list of items they bought' do 
        supermarket_1 = Supermarket.create!(name: Faker::Address.community, location: Faker::Address.city)
        customer_1 = supermarket_1.customers.create!(name: Faker::Name.name)
        customer_2 = supermarket_1.customers.create!(name: Faker::Name.name)

        item_1 = Item.create!(name: "milk", price: 7)
        item_2 = Item.create!(name: "cabbage", price: 5)
        item_3 = Item.create!(name: 'crackers', price: 2)

        CustomerItem.create!(customer_id: customer_1.id, item_id: item_1.id)
        CustomerItem.create!(customer_id: customer_1.id, item_id: item_2.id)
        CustomerItem.create!(customer_id: customer_2.id, item_id: item_3.id)

        visit customer_path(customer_1) 

        expect(page).to have_content(supermarket_1.name)
    end

    # Story 2 of 3
    # As a visitor,
    # When I visit a customer show page,
    # I see the total price of all of its items
    it 'shows the total price of all its items' do 
        supermarket_1 = Supermarket.create!(name: Faker::Address.community, location: Faker::Address.city)
        customer_1 = supermarket_1.customers.create!(name: Faker::Name.name)

        item_1 = Item.create!(name: "milk", price: 7)
        item_2 = Item.create!(name: "cabbage", price: 5)
        item_3 = Item.create!(name: 'crackers', price: 2)

        CustomerItem.create!(customer_id: customer_1.id, item_id: item_1.id)
        CustomerItem.create!(customer_id: customer_1.id, item_id: item_2.id)
        CustomerItem.create!(customer_id: customer_1.id, item_id: item_3.id)

        visit customer_path(customer_1) 
        save_and_open_page

        expect(page).to have_content("Total Item Price: $14.00")
    end
end