class BasePage
  include RSpec::Matchers
  include Capybara::DSL
  include Rails.application.routes.url_helpers
end
