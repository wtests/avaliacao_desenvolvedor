# == Schema Information
#
# Table name: import_files
#
#  id          :integer          not null, primary key
#  file        :string           not null
#  order_count :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe ImportFile, type: :model do
  context 'validations' do 
    it { is_expected.to validate_presence_of(:file) }
  end

  context 'relations' do
    it { is_expected.to have_many :orders }
  end

  describe '#total' do
    it 'return the sum of order values' do
      import_file = FactoryBot.create(:import_file)
      orders = FactoryBot.create_list(:order, 3, import_file: import_file)

      expect(import_file.total).to eq(orders.pluck(:value).sum)
    end
  end
end

