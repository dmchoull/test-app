require_relative '../features/pages/base_page'
require_relative '../features/pages/home_page'
require_relative '../features/pages/sign_up_page'
require_relative '../features/pages/profile_page'

module PageHelper
  def self.included(feature)
    feature.instance_eval do
      let(:home_page) { HomePage.new }
      let(:sign_up_page) { SignUpPage.new }
      let(:profile_page) { ProfilePage.new }
    end
  end
end
