describe User, type: :model do
  it { is_expected.to have_one :profile }
end
