require 'rails_helper'

RSpec.describe '/general_shoping', type: :request do
  let(:user) { User.create!(email: 'testing@gmail.com', password: 'f4k3p455w0rd') }

  before(:each) do
    login_as(user, scope: :user)
    Food.create(name: 'Rice', measurement_unit: 'kg', price: 10, quantity: -20, user:)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get general_shoping_list_url
      expect(response).to be_successful
    end
  end
end
