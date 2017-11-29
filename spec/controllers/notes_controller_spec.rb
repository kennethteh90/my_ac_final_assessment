require 'rails_helper'

RSpec.describe NotesController, type: :controller do

  let!(:note) { create(:note) }

  describe 'GET#index' do

    context 'No user logged in, show all users and notes' do

      before { get :index }

      it { expect(assigns(:users).count).to eq(1) }
      it { expect(assigns(:notes).count).to eq(1) }
      it { expect(assigns(:note)).to be_a(Note) }

    end

    context 'User logged in, only show followed users and notes (besides own)' do

      before do
        sign_in note.user
        get :index
      end

      it { expect(assigns(:users)).to be_empty }
      it { expect(assigns(:notes).count).to eq(1) }

    end

  end

  describe 'POST#create' do

    context 'when save is successful' do

      before do
        sign_in note.user
        post :create, params: { note: attributes_for(:note) }
      end

      it { expect(assigns(:note)).to be_a(Note) }
      it { is_expected.to set_flash[:notice] }
      it { expect(:subject).to redirect_to(notes_path) }

    end

    context 'when save is unsuccessful' do

      before do
        sign_in note.user
        post :create, params: { note: attributes_for(:note, :invalid) }
      end

      it { expect(assigns(:note)).to be_a(Note) }
      it { is_expected.to set_flash.now[:alert] }
      it { expect(:subject).to render_template(:index) }

    end

  end

  describe 'DELETE#destroy' do

    before do
      sign_in note.user
      delete :destroy, params: {id: note }
    end

    it { expect(assigns(:note)).to be_destroyed }
    it { is_expected.to set_flash[:alert] }
    it { expect(:subject).to redirect_to(notes_path) }

  end

  describe 'GET#edit' do

    before do
      sign_in note.user
      get :edit, params: {id: note }
    end

    it { expect(assigns(:note)).to eq(note) }

  end

  describe 'POST#update' do

    context 'when update is successful' do

      before do
        sign_in note.user
        post :update, params: { id: note, note: attributes_for(:note, title: 'whee') }
      end

      it { is_expected.to set_flash[:notice] }
      it { expect(assigns(:note)).to have_attributes(title: 'whee') }
      it { expect(:subject).to redirect_to(notes_path) }

    end

    context 'when update is unsuccessful' do

      before do
        sign_in note.user
        post :update, params: { id: note, note: attributes_for(:note, :invalid) }
      end

      it { is_expected.to set_flash.now[:alert] }
      it { expect(:subject).to render_template(:edit) }

    end

  end

end
