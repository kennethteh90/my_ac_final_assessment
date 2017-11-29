require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'get #index' do

    let(:user) { create_list(:user, 3) }

    before do
      sign_in user[0]
      get :index
    end

    it { expect(assigns(:users).count).to eq(2) }
  end
end
