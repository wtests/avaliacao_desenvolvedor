class AddImportFileIdToOrders < ActiveRecord::Migration[5.2]
  def self.up
    add_column :orders, :import_file_id, :integer
    add_foreign_key :orders, :import_files
  end

  def self.down
    remove_column :orders, :import_file_id
    remove_foreign_key :orders, :import_files
  end
end
