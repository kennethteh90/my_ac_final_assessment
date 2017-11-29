require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do

  describe 'POST#create' do

    let(:user) { create(:user) }

    before { post :create, params: { format: user } }

    # it { expect(assigns(:user)).to eq(user) }
    # it { expect(assigns(:user)).to be }
  end

end
