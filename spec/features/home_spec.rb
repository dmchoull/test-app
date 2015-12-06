feature 'Home page' do
  include PageHelper

  before do
    home_page.open
  end

  scenario 'allows new user to sign up' do
    home_page.click_sign_up

    sign_up_page.sign_up

    profile_page.expect_displayed
  end

  scenario 'allows existing user to sign in' do
    user = create(:user)
    home_page.sign_in(user)

    profile_page.expect_displayed
  end
end
