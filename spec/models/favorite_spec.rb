require 'rails_helper'

RSpec.describe Favorite, type: :model do

  describe 'validations' do 
    it { validate_uniqueness_of(:user_id).scoped_to(:article_id) }
  end

  describe 'associations' do 
    let(:favorite) { create(:favorite) }

    it { expect(favorite).to belong_to(:user) }
    it { expect(favorite).to belong_to(:article) }
  end
end
