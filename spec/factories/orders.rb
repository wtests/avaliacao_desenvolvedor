# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  address        :string
#  customer_name  :string           not null
#  description    :string           not null
#  provider       :string
#  quantity       :integer          not null
#  value          :decimal(8, 2)    not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  import_file_id :integer
#

FactoryBot.define do
  factory :order do
    customer_name { Faker::Name.name }
    description { Faker::Commerce.product_name }
    value { Faker::Commerce.price }
    quantity { [*1..10].sample }
    address { Faker::Address.street_address }
    provider { Faker::Company.name }
    import_file
  end
end

