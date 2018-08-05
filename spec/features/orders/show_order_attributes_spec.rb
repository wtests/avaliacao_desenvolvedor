require 'rails_helper'
feature 'Show order details' do
  let(:order){FactoryBot.create(:order)}
  
  scenario 'See order attributes', js: true do
    order
    visit root_path
    
    within "#order_#{order.id}" do
      click_link 'Ver'
    end

    expect(page).to have_content(order.customer_name)
    expect(page).to have_content(order.description)
  end
end
