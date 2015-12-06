class SignUpPage < BasePage
  def sign_up
    within('#new_user') do
      fill_in 'Email', with: 'jdoe@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Confirm Password', with: 'password'
    end

    click_button 'Sign up'
  end
end
