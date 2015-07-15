describe Ability, type: :model do
  let(:admin) { build_stubbed(:user).tap { |u| allow(u).to receive(:has_role?).with(:admin).and_return true } }
  let(:user) { build_stubbed(:user) }

  context 'admin user' do
    subject(:ability) { Ability.new(admin) }
    let(:own_profile) { build_stubbed(:profile, user: admin) }
    let(:other_profile) { build_stubbed(:profile, user: user) }

    it { is_expected.to be_able_to(:manage, own_profile) }

    it { is_expected.to be_able_to(:manage, other_profile) }
  end

  context 'regular user' do
    subject(:ability) { Ability.new(user) }
    let(:own_profile) { build_stubbed(:profile, user: user) }
    let(:other_profile) { build_stubbed(:profile) }

    it { is_expected.to be_able_to(:manage, own_profile) }

    it { is_expected.not_to be_able_to(:read, other_profile) }
  end
end