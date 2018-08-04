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

FactoryBot.define do
  factory :import_file do
    file { Rack::Test::UploadedFile.new(
      File.open( File.join(Rails.root, 'spec', 'support', 'order', 'dados.txt') ) 
    ) }

    factory :invalid_import_file do
      file { Rack::Test::UploadedFile.new(
      File.open( File.join(Rails.root, 'spec', 'support', 'order', 'invalid.txt') ) 
    ) }
    end
  end
end
