require 'rails_helper'
feature 'import orders from file' do 

  let(:valid) { File.join(Rails.root, 'spec', 'support', 'order', 'dados.txt') }
  let(:invalid) { File.join(Rails.root, 'spec', 'support', 'order', 'invalid.txt') }

  scenario 'upload file', js: true do
    visit root_path

    click_button 'Importar pedidos'

    attach_file('Arquivo', valid)

    click_button 'Importar'
    
    ["João Silva", "Amy Pond", "Marty McFly", "Snake Plissken"].each do |product|
      expect(page).to have_content(product)
    end
  end

  scenario 'see error message when file is not valid', js: true do
    visit root_path

    click_button 'Importar pedidos'

    attach_file('Arquivo', invalid)

    click_button 'Importar'
    
    expect(page).to have_content('Arquivo em formato inválido')
  end

  scenario 'see a list of imported files with sum of values', js: true do
    import_file = FactoryBot.create(:import_file)
    importer = Importer.new(import_file)
    importer.import

    visit root_path

    expect(find("#import_file_#{import_file.id}")).to have_text("R$ 30,00")
    expect(find("#import_file_#{import_file.id}")).to have_text(import_file.file.filename)
  end
end