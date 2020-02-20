require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do 
    it { expect(create(:user).save).to eq(true) }
    it { expect(build(:user, password: '12').save).to eq(false) }
    it { expect(build(:user, password: '').save).to eq(false) }
    it { expect(build(:user, name: '').save).to eq(false) }
    it { expect(build(:user, sign: '').save).to eq(false) }
    it { validate_uniqueness_of(:login) }
  end

  describe "associations" do
    let(:user) { create(:user) }

    it { expect(user).to have_many(:looks).dependent(:destroy) }
    it { expect(user).to have_many(:favorites).dependent(:destroy) }
    it { expect(user).to have_many(:articles) }
  end

  describe "scope" do
    it "non_authors" do
      users = create_list(:user, 5)
      user_with_articles = create(:user_with_articles, articles_count: 5)
      expect(User.non_authors).to eq(users)
    end
  end
end
