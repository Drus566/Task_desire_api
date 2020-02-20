require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do

    describe '#authenticate' do 
        let(:user) { create(:user) }
        
        it 'status 200' do 
            get :authenticate, :params => { "login": user.login, "password": user.password }
            expect(response.status).to eq(200)
        end 

        it 'auth token' do 
            get :authenticate, :params => { "login": user.login, "password": user.password }
            expect(response.body).to match("auth_token")
        end 
    end
end
