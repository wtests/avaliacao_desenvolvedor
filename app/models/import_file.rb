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

class ImportFile < ApplicationRecord
  validates :file, presence: true

  mount_uploader :file, ::ImportFileUploader

  has_many :orders

  def total
    orders.pluck(:value).sum
  end
end
