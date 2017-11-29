require 'rails_helper'

RSpec.describe Note, type: :model do

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }
  it { is_expected.to have_many(:likers).class_name('User').through(:likes) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }

end
