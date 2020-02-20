require 'rails_helper'

RSpec.describe Look, type: :model do

  describe 'validations' do 
    it { validate_uniqueness_of(:user_id).scoped_to(:article_id) }
  end

  describe 'associations' do 
    let(:look) { create(:look) }

    it { expect(look).to belong_to(:user) }
    it { expect(look).to belong_to(:article) }
  end
end
