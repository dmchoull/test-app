module ControllerMacros
  def login_user(user_factory=:user)
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @current_user = create(user_factory)
      sign_in @current_user
    end
  end
end