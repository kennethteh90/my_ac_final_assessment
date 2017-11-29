require 'rails_helper'

RSpec.describe User, type: :model do

  it { is_expected.to have_many(:notes).dependent(:destroy) }
  it { is_expected.to have_many(:active_relationships).class_name('Relationship').with_foreign_key(:follower_id).dependent(:destroy) }
  it { is_expected.to have_many(:followees).through(:active_relationships) }
  it { is_expected.to have_many(:passive_relationships).class_name('Relationship').with_foreign_key(:followee_id).dependent(:destroy) }
  it { is_expected.to have_many(:followers).through(:passive_relationships) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }
  it { is_expected.to have_many(:liked).class_name('Note').through(:likes).source(:note) }

  describe 'follow' do

    let(:user) { create_list(:user, 2) }

    before { user[0].follow(user[1]) }

    it { expect(user[0].followees.count).to eq(1) }

  end

  describe 'unfollow' do

    let(:user) { create_list(:user, 2) }

    before do
      user[0].follow(user[1])
      user[0].unfollow(user[1])
    end

    it { expect(user[0].followees.count).to eq(0) }
    it { expect(user[0].following?(user[1])).to be(false) }

  end

  describe 'following?' do

    let(:user) { create_list(:user, 2) }

    before { user[0].follow(user[1]) }

    it { expect(user[0].following?(user[1])).to be(true) }

  end

  describe 'like' do

    let(:user) { create(:user) }
    let(:note) { create(:note) }

    before { user.like(note) }

    it { expect(user.liked.count).to eq(1) }

  end

  describe 'liked' do

    let(:user) { create(:user) }
    let(:note) { create(:note) }

    before { user.like(note) }

    it { expect(user.liked?(note)).to eq(true) }

  end

  describe 'unlike' do

    let(:user) { create(:user) }
    let(:note) { create(:note) }

    before do
      user.like(note)
      user.unlike(note)
    end

    it { expect(user.liked?(note)).to eq(false) }
    it { expect(user.liked.count).to eq(0) }

  end

end
