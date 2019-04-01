class LoginController < ApplicationController
  skip_before_action :authenticate

  def create
    l = LoginService.new(params: login_params)
    begin
      user = l.login
      serializer = UserLoginSerializer.new(user).serialized_json
      render json: serializer
    rescue => e
      render json: { error_message: e.message }
    end
  end

  private

  def login_params
    params.require(:login).permit(:access_token, :refresh_token)
  end
end
