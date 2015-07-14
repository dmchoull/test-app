describe Profile, type: :model do
  it { is_expected.to belong_to :user}
  it { is_expected.to validate_uniqueness_of :user_id }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :bio }
end
