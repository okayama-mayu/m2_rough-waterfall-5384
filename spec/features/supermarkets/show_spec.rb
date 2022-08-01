require 'rails_helper' 

RSpec.describe 'Supermarket Show Page', type: :feature do 
    # Story 3 of 3
    # As a visitor,
    # When I visit a supermarket show page,
    # I see the name of that supermarket,
    # And I see a link to view all of the items that the supermarket has
    it 'has the name of the supermarket and a link to view all of the items the supermarket has' do 
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
        CustomerItem.create!(customer_id: customer_2.id, item_id: item_3.id)
        CustomerItem.create!(customer_id: customer_2.id, item_id: item_4.id)

        visit supermarket_path(supermarket_1)

        expect(page).to have_content(supermarket_1.name)
        expect(page).to_not have_content(supermarket_2.name)
        expect(page).to have_link("View All Items in Supermarket")
    end

    # And when I click on the link,
    # I am taken to the supermarkets item index page,
    # And I can see a UNIQUE list of all the items that the supermarket has
end