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

require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:customer_name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_numericality_of(:value) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity) }
    it { is_expected.to validate_presence_of(:import_file) }
  end

  context 'relations' do
    it { is_expected.to belong_to(:import_file).counter_cache(:order_count) }
  end
end

