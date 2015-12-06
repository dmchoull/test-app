class HomePage < BasePage
  def open
    visit root_path
  end

  def click_sign_up
    click_link 'Sign up'
  end

  def sign_in(user)
    within '#new_user' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end

    click_button 'Log in'
  end
end
