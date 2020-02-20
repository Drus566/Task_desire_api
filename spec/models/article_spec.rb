require 'rails_helper'

RSpec.describe Article, type: :model do

  describe 'validations' do 
    it { expect(create(:article).save).to eq(true) }
    it { expect(build(:article, head: '').save).to eq(false) }
    it { expect(build(:article, announcement: '').save).to eq(false) }
    it { expect(build(:article, content: '').save).to eq(false) }
    it { expect(build(:article, user_id: '').save).to eq(false) }
  end

  describe 'associations' do
    let(:article) { create(:article) }

    it { expect(article).to have_many(:looks).dependent(:destroy) }
    it { expect(article).to have_many(:favorites).dependent(:destroy) }
    it { expect(article).to belong_to(:user) }
  end
end
