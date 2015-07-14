describe ProfilesController, type: :controller do
  login_user

  let(:valid_attributes) {
    attributes_for(:profile)
  }

  let(:invalid_attributes) {
    attributes_for(:profile, name: nil)
  }

  describe 'GET #index' do
    it 'assigns all profiles as @profiles' do
      profile = create(:profile, valid_attributes)
      get :index, {}
      expect(assigns(:profiles)).to eq([profile])
    end
  end

  describe 'GET #profile' do
    context 'current user has a profile' do
      it 'assigns the current user`s profile as @profile' do
        profile = create(:profile, user: @current_user)
        get :profile, {}
        expect(assigns(:profile)).to eq(profile)
      end
    end

    context 'current user does not have a profile' do
      it 'assigns a new profile as @profile' do
        get :profile, {}
        expect(assigns(:profile)).to be_a_new(Profile)
      end

      it 'renders the new profile template' do
        get :profile, {}
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested profile as @profile' do
      profile = create(:profile, valid_attributes)
      get :show, {user_id: profile.user.to_param}
      expect(assigns(:profile)).to eq(profile)
    end
  end

  describe 'GET #new' do
    it 'assigns a new profile as @profile' do
      get :new, {user_id: @current_user.to_param}
      expect(assigns(:profile)).to be_a_new(Profile)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested profile as @profile' do
      profile = create(:profile, valid_attributes)
      get :edit, {user_id: profile.user.to_param}
      expect(assigns(:profile)).to eq(profile)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Profile' do
        expect {
          post :create, {user_id: @current_user.to_param, profile: valid_attributes}
        }.to change(Profile, :count).by(1)
      end

      it 'assigns a newly created profile as @profile' do
        post :create, {user_id: @current_user.to_param, profile: valid_attributes}
        expect(assigns(:profile)).to be_a(Profile)
        expect(assigns(:profile)).to be_persisted
      end

      it 'redirects to the created profile' do
        post :create, {user_id: @current_user.to_param, profile: valid_attributes}
        expect(response).to redirect_to([@current_user, Profile.last])
      end

      it 'associates the new profile with the current user' do
        post :create, {user_id: @current_user.to_param, profile: valid_attributes}
        @current_user.reload
        expect(@current_user.profile).to eq(Profile.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved profile as @profile' do
        post :create, {user_id: @current_user.to_param, profile: invalid_attributes}
        expect(assigns(:profile)).to be_a_new(Profile)
      end

      it 're-renders the "new" template' do
        post :create, {user_id: @current_user.to_param, profile: invalid_attributes}
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        attributes_for(:profile, bio: 'updated bio')
      }

      it 'updates the requested profile' do
        profile = create(:profile, valid_attributes)
        put :update, {user_id: profile.user.to_param, profile: new_attributes}
        profile.reload
        expect(profile.bio).to eq(new_attributes[:bio])
      end

      it 'assigns the requested profile as @profile' do
        profile = create(:profile, valid_attributes)
        put :update, {user_id: profile.user.to_param, profile: valid_attributes}
        expect(assigns(:profile)).to eq(profile)
      end

      it 'redirects to the profile' do
        profile = create(:profile, valid_attributes)
        put :update, {user_id: profile.user.to_param, profile: valid_attributes}
        expect(response).to redirect_to([@current_user, profile])
      end
    end

    context 'with invalid params' do
      it 'assigns the profile as @profile' do
        profile = create(:profile, valid_attributes)
        put :update, {user_id: profile.user.to_param, profile: invalid_attributes}
        expect(assigns(:profile)).to eq(profile)
      end

      it 're-renders the "edit" template' do
        profile = create(:profile, valid_attributes)
        put :update, {user_id: profile.user.to_param, profile: invalid_attributes}
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested profile' do
      profile = create(:profile, valid_attributes)
      expect {
        delete :destroy, {user_id: profile.user.to_param}
      }.to change(Profile, :count).by(-1)
    end

    it 'redirects to the profiles list' do
      profile = create(:profile, valid_attributes)
      delete :destroy, {user_id: profile.user.to_param}
      expect(response).to redirect_to(user_root_path)
    end
  end
end
