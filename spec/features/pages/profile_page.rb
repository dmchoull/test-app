class ProfilePage < BasePage
  def expect_displayed
    expect(page).to have_content 'My Profile'
  end

  def submit_complete_profile
    within('#new_profile') do
      fill_in 'Name', with: 'Test User'
      fill_in 'Bio', with: 'Test bio'
    end

    click_button 'Create Profile'
  end

  def submit_incomplete_profile
    within('#new_profile') do
      fill_in 'Name', with: 'Test User'
    end

    click_button 'Create Profile'
  end

  def update
    bio_field = find('#profile_bio')
    @existing_bio = bio_field.value
    bio_field.set(@existing_bio + 'additional bio')

    click_button 'Update Profile'
  end

  def expect_profile_created
    expect(page).to have_content 'Profile was successfully created.'
    expect(Profile.count).to eq(1)
    expect(Profile.last.attributes.symbolize_keys).to include(name: 'Test User', bio: 'Test bio')
  end

  def expect_profile_not_created
    expect(page).to have_content 'Bio can\'t be blank'
    expect(Profile.count).to eq(0)
  end

  def expect_profile_displayed(profile)
    expect(find('#profile_name').value).to eq(profile.name)
    expect(find('#profile_bio').value).to eq(profile.bio)
  end

  def expect_profile_updated(profile)
    updated_bio = @existing_bio + 'additional bio'
    expect(find('#profile_bio').value).to eq(updated_bio)
    expect(profile.reload.bio).to eq(updated_bio)
  end
end
