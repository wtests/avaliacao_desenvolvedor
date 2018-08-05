require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'GET #index' do
    it 'assign orders to @order' do
      orders = FactoryBot.create_list(:order, 3)
      get :index
      expect(assigns[:orders]).to match_array(orders)
    end

    it 'render template index' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'return http status success' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'assigns a new import file to @import_file' do
      get :index
      expect(assigns[:import_file]).to be_a_new(ImportFile)
    end
  end

  describe 'GET #show' do
    context 'when order exist' do
      let(:order) { FactoryBot.create(:order) }

      before do
        get :show, params: { id: order.id }
      end

      it 'assigns order to @order' do
        expect(assigns[:order]).to eq(order)
      end

      it 'return http status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'render template show' do
        expect(response).to render_template(:show)
      end
    end

    context 'when order do not exist' do
      it 'raise a ActiveRecord::RecordNotFound exception' do
        expect {
          get :show, params: {id: -9999}
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#import' do
    let(:import_file) { FactoryBot.attributes_for(:import_file) }
    let(:invalid_import_file) { FactoryBot.attributes_for(:invalid_import_file) }

    it 'create orders from file' do
      expect {
        post :import, params: { import_file: import_file }
      }.to change(Order, :count).by(4)
    end

    it 'set flash error with message when file is invalid' do
      post :import, params: { import_file: invalid_import_file }
      expect(controller).to set_flash[:error]
    end
  end
end
