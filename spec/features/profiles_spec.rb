feature 'Profile page' do
  include PageHelper

  background do
    home_page.open
    home_page.sign_in(user)
  end

  feature 'without an existing profile' do
    given(:user) { create(:user) }

    scenario 'creates new profile when all fields completed' do
      profile_page.submit_complete_profile
      profile_page.expect_profile_created
    end

    scenario 'does not create profile when required field missing' do
      profile_page.submit_incomplete_profile
      profile_page.expect_profile_not_created
    end
  end

  feature 'with an existing profile' do
    given(:user) { create(:profile).user }

    scenario 'displays profile' do
      profile_page.expect_profile_displayed(user.profile)
    end

    scenario 'allows updating profile' do
      profile_page.update
      profile_page.expect_profile_updated(user.profile)
    end
  end

  feature 'viewing another user`s profile' do
    given(:user) { create(:user) }
    given(:other_user) { create(:profile).user }

    scenario 'is not allowed as a regular user' do
      expect { profile_page.open(other_user.profile) }.to raise_error CanCan::AccessDenied
    end

    scenario 'is allowed as an admin' do
      user.add_role :admin
      expect { profile_page.open(other_user.profile) }.to_not raise_error
    end
  end
end
