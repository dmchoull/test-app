module ControllerMacros
  def login_user(user_factory = :user)
    let!(:current_user) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      current_user = create(user_factory)
      sign_in current_user
      current_user
    end
  end
end
