class ApplicationController < ActionController::API
  before_action :authenticate

  private

  def authenticate
    token = request.headers[:EONEXT_LOGIN_TOKEN]
    if token.present?
      u = User.find_by(login_token: token)
      @current_resource_owner = u if u.present?
    end

    if token.blank? || @current_resource_owner.blank?
      render json: { error_message: "再ログインが必要です" }
    end
  end

end
