class LoginController < ApiController
  def create
    l = LoginService.new(login_params)
    begin
      user = l.login
      serializer = UserLoginSerializer.new(user, options).serialized_json
      render json: serializer
    rescue => e
    end
  end

  private

  def login_params
    params.permit(:access_token, :refresh_token)
  end
end
