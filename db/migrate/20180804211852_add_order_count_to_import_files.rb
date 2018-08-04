class AddOrderCountToImportFiles < ActiveRecord::Migration[5.2]
  def change
    add_column :import_files, :order_count, :integer, default: 0
  end
end
