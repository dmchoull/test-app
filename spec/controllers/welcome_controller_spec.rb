require 'rails_helper'

describe WelcomeController do
  context 'with signed-in user' do
    login_user

    it 'should succeed' do
      get :index
      expect(response).to be_success
    end
  end

  context 'without signed-in user' do
    it 'should redirect to sign in page' do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end
end