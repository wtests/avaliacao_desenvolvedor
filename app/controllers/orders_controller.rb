class OrdersController < ApplicationController
  def index
    @orders = Order.page(params[:page])
    @import_file = ImportFile.new
    @import_files = ImportFile.includes(:orders).all
  end

  def show
    @order = Order.find(params[:id])
  end

  def import
    @imported_file = ImportFile.new(params.fetch(:import_file, {}).permit(:file))

    if @imported_file.save
      begin
        importer = Importer.new(@imported_file)
        importer.import
      rescue Exception => ex
        flash[:error] = "Arquivo em formato inválido"    
      end
    else
      flash[:error] = "Arquivo em formato inválido"    
    end

    redirect_to root_path
  end
end
