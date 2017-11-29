require 'rails_helper'

RSpec.describe LikesController, type: :controller do

  describe 'POST#create' do

    let(:note) { create(:note) }

    before do
      sign_in note.user
      post :create, params: { format: note }
    end

    it { expect(assigns(:note)).to eq(note) }
    it { is_expected.to set_flash[:notice] }
    it { is_expected.to redirect_to(notes_path) }
  end

  describe 'DELETE#destroy' do

    let(:note) { create(:note) }

    before do
      sign_in note.user
      delete :destroy, params: { id: note }
    end

    it { expect(assigns(:note)).to eq(note) }
    it { is_expected.to set_flash[:notice] }
    it { is_expected.to redirect_to(notes_path) }
  end

end
