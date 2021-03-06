describe ProfilesController, type: :controller do
  login_user

  let(:valid_attributes) { attributes_for(:profile) }

  let(:invalid_attributes) { attributes_for(:profile, name: nil) }

  describe 'GET #index' do
    context 'admin user' do
      before { current_user.add_role :admin }

      it 'assigns all profiles as @profiles' do
        profile = create(:profile, valid_attributes)
        get :index, {}
        expect(assigns(:profiles)).to eq([profile])
      end
    end

    context 'regular user' do
      it 'raises a security exception' do
        create(:profile, valid_attributes)
        expect { get :index, {} }.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe 'GET #profile' do
    context 'current user has a profile' do
      it 'assigns the current user`s profile as @profile' do
        profile = create(:profile, user: current_user)
        get :profile, {}
        expect(assigns(:profile)).to eq(profile)
      end
    end

    context 'current user does not have a profile' do
      it 'assigns a new profile as @profile' do
        get :profile, {}
        expect(assigns(:profile)).to be_a_new(Profile)
      end
    end
  end

  describe 'GET #show' do
    it 'renders the "profile" template' do
      profile = create(:profile, valid_attributes.merge(user: current_user))
      get :show, user_id: profile.user.to_param
      expect(response).to render_template('profile')
    end

    context 'admin user' do
      before { current_user.add_role :admin }

      it 'assigns the requested profile as @profile' do
        profile = create(:profile, valid_attributes)
        get :show, user_id: profile.user.to_param
        expect(assigns(:profile)).to eq(profile)
      end
    end

    context 'regular user' do
      context 'own profile' do
        it 'assigns the requested profile as @profile' do
          profile = create(:profile, valid_attributes.merge(user: current_user))
          get :show, user_id: profile.user.to_param
          expect(assigns(:profile)).to eq(profile)
        end
      end

      context 'other profile' do
        it 'raises an error' do
          profile = create(:profile, valid_attributes)
          expect { get :show, user_id: profile.user.to_param }.to raise_error CanCan::AccessDenied
        end
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Profile' do
        expect do
          post :create, user_id: current_user.to_param, profile: valid_attributes
        end.to change(Profile, :count).by(1)
      end

      it 'assigns a newly created profile as @profile' do
        post :create, user_id: current_user.to_param, profile: valid_attributes
        expect(assigns(:profile)).to be_a(Profile)
        expect(assigns(:profile)).to be_persisted
      end

      it 'redirects to the created profile' do
        post :create, user_id: current_user.to_param, profile: valid_attributes
        expect(response).to redirect_to(user_root_path)
      end

      it 'associates the new profile with the current user' do
        post :create, user_id: current_user.to_param, profile: valid_attributes
        current_user.reload
        expect(current_user.profile).to eq(Profile.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved profile as @profile' do
        post :create, user_id: current_user.to_param, profile: invalid_attributes
        expect(assigns(:profile)).to be_a_new(Profile)
      end

      it 're-renders the "new" template' do
        post :create, user_id: current_user.to_param, profile: invalid_attributes
        expect(response).to render_template('profile')
      end
    end
  end

  describe 'PUT #update' do
    let(:profile) { create(:profile, valid_attributes.merge(user: current_user)) }

    context 'with valid params' do
      let(:new_attributes) { attributes_for(:profile, bio: 'updated bio') }

      it 'updates the requested profile' do
        put :update, user_id: profile.user.to_param, profile: new_attributes
        profile.reload
        expect(profile.bio).to eq(new_attributes[:bio])
      end

      it 'assigns the requested profile as @profile' do
        put :update, user_id: profile.user.to_param, profile: valid_attributes
        expect(assigns(:profile)).to eq(profile)
      end

      it 'redirects to the profile' do
        put :update, user_id: profile.user.to_param, profile: valid_attributes
        expect(response).to redirect_to(user_profile_path(profile.user, profile))
      end
    end

    context 'with invalid params' do
      it 'assigns the profile as @profile' do
        put :update, user_id: profile.user.to_param, profile: invalid_attributes
        expect(assigns(:profile)).to eq(profile)
      end

      it 're-renders the "profile" template' do
        put :update, user_id: profile.user.to_param, profile: invalid_attributes
        expect(response).to render_template('profile')
      end
    end

    context 'with another user`s profile' do
      let(:profile) { create(:profile, valid_attributes) }

      context 'as a regular user' do
        it 'raises an error' do
          expect do
            put :update, user_id: profile.user.to_param, profile: valid_attributes
          end.to raise_error CanCan::AccessDenied
        end
      end

      context 'as an admin user' do
        before do
          create(:profile, valid_attributes.merge(user_id: current_user.id))
          current_user.add_role :admin
        end

        it 'does not raise an error and updates the user`s bio' do
          expect do
            put :update, user_id: profile.user.to_param, profile: valid_attributes.merge(bio: 'updated')
          end.not_to raise_error

          expect(profile.reload.bio).to eq('updated')
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:profile) { create(:profile, valid_attributes.merge(user: current_user)) }

    it 'destroys the requested profile' do
      profile
      expect do
        delete :destroy, user_id: profile.user.to_param
      end.to change(Profile, :count).by(-1)
    end

    it 'redirects to the profiles list' do
      delete :destroy, user_id: profile.user.to_param
      expect(response).to redirect_to(user_root_path)
    end

    context 'with another user`s profile' do
      let(:profile) { create(:profile, valid_attributes) }

      context 'as a regular user' do
        it 'raises an error' do
          expect { delete :destroy, user_id: profile.user.to_param }.to raise_error CanCan::AccessDenied
        end
      end

      context 'as an admin user' do
        before { current_user.add_role :admin }

        it 'does not raise an error' do
          expect { delete :destroy, user_id: profile.user.to_param }.not_to raise_error
        end
      end
    end
  end
end
