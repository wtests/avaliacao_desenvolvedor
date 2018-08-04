require 'rails_helper'
RSpec.describe Importer do
  let(:path) { File.join(Rails.root, 'spec', 'support', 'order', 'dados.txt') } 
  let(:invalid) { File.join(Rails.root, 'spec', 'support', 'order', 'invalid.txt') } 
  let(:blank_path) { File.join(Rails.root, 'spec', 'support', 'order', 'blank.txt') }
  let(:no_header_path) { File.join(Rails.root, 'spec', 'support', 'order', 'no_header.txt') }
  
  let(:importer) { Importer.new(imported_file) }
  let(:imported_file) { FactoryBot.create(:import_file) }

  describe '.initialize' do
    it 'instantiate @path with file path' do
      expect(importer.path).to eq(imported_file.file.path)
    end
  end

  describe '#valid?' do
    it 'is valid with header' do
      expect(importer.valid?).to eq(true)
    end
    
    it 'is invalid without header' do
      no_header = Importer.new(FactoryBot.create(:import_file, file: File.new(no_header_path)))
      expect(no_header.valid?).to eq(false)
    end

    it 'is invalid with blank file' do
      blank = Importer.new(FactoryBot.create(:import_file, file: File.new(blank_path)))
      expect(blank.valid?).to eq(false)
    end
  end

  describe '#get_header' do
    it 'return file header' do
      expect(importer.get_header).to eq("Comprador\tdescrição\tPreço Uniário\tQuantidade\tEndereço\tFornecedor\n")
    end
  end

  describe '#parse' do
    it 'return order object from string' do
      expect(importer.parse("João Silva\tR$10 off R$20 of food\t10.0\t2\t987 Fake St\tBob's Pizza")).to eq({
        customer_name: 'João Silva', description: 'R$10 off R$20 of food', value: 10.0, quantity: 2, address: '987 Fake St', provider: "Bob's Pizza"
      })
    end

    it 'raise exception when string is not in valid format' do
      expect {
        importer.parse("invalid string")
      }.to raise_error Exception
    end
  end

  describe '#get_rows' do
    it 'return a array with values from file' do
      expect(importer.get_rows.size).to eq(4)
    end
  end

  describe '#import' do
    it 'add records from txt to dataImporter when all valid' do
      expect {
        importer.import
      }.to change(Order, :count).by(4)
    end

    it 'raise exception with invalid files' do
      importer = (FactoryBot.create(:import_file, file: File.new(invalid)))
      expect {
        importer.import
      }.to raise_error Exception
    end
  end
end